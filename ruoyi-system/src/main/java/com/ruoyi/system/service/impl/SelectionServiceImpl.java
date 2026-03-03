package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.domain.entity.CouClassQuota;
import com.ruoyi.common.core.domain.entity.CouCourse;
import com.ruoyi.common.core.domain.entity.StuSelection;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.CartItemVO;
import com.ruoyi.system.domain.MySelectionVO;
import com.ruoyi.system.mapper.CouClassQuotaMapper;
import com.ruoyi.system.mapper.CouCourseMapper;
import com.ruoyi.system.mapper.StuSelectionMapper;
import com.ruoyi.system.mapper.StuStudentInfoMapper;
import com.ruoyi.system.service.ISelectionService;
import com.ruoyi.system.service.ISysSemesterService;

/**
 * 选课服务 实现
 *
 * @author ruoyi
 */
@Service
public class SelectionServiceImpl implements ISelectionService {
    private static final int CART_EXPIRE_MINUTES = 30;
    private static final int SUBMIT_LOCK_SECONDS = 10;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private StuSelectionMapper selectionMapper;

    @Autowired
    private CouCourseMapper courseMapper;

    @Autowired
    private CouClassQuotaMapper quotaMapper;

    @Autowired
    private StuStudentInfoMapper studentMapper;

    @Autowired
    private ISysSemesterService semesterService;

    private String cartKey(Long studentId, Long semesterId) {
        return CacheConstants.SELECTION_CART_KEY + studentId + ":" + semesterId;
    }

    private String submitLockKey(Long studentId, Long semesterId) {
        return CacheConstants.SELECTION_SUBMIT_LOCK_KEY + studentId + ":" + semesterId;
    }

    private void checkSelectionWindow(Long semesterId) {
        com.ruoyi.common.core.domain.entity.SysSemester semester = semesterService.selectSemesterById(semesterId);
        if (semester == null) {
            throw new ServiceException("当前学期不存在");
        }
        if (semester.getSelectionStartTime() == null || semester.getSelectionEndTime() == null) {
            // 若未设置时间，默认不限制（或可根据需求改为默认禁止）
            return;
        }

        java.util.Date now = new java.util.Date();
        if (now.before(semester.getSelectionStartTime())) {
            throw new ServiceException("选课尚未开始，开始时间：" + com.ruoyi.common.utils.DateUtils
                    .parseDateToStr("yyyy-MM-dd HH:mm:ss", semester.getSelectionStartTime()));
        }
        if (now.after(semester.getSelectionEndTime())) {
            throw new ServiceException("选课已经结束");
        }
    }

    @Override
    public Map<Integer, CartItemVO> getCart(Long studentId, Long semesterId) {
        String key = cartKey(studentId, semesterId);
        Map<String, CartItemVO> raw = redisCache.getCacheMap(key);
        Map<Integer, CartItemVO> result = new HashMap<>();
        if (raw != null && !raw.isEmpty()) {
            for (Map.Entry<String, CartItemVO> e : raw.entrySet()) {
                try {
                    result.put(Integer.parseInt(e.getKey()), e.getValue());
                } catch (NumberFormatException ignored) {
                }
            }
        }
        // 指定课程不放入选课车：从 DB 查出 assigned 的 weekDay，从 result 中移除（含 Redis 中旧数据）
        List<MySelectionVO> mySelections = selectionMapper.selectMySelections(studentId, semesterId);
        if (mySelections != null) {
            for (MySelectionVO s : mySelections) {
                if (s.getWeekDay() != null && Integer.valueOf(1).equals(s.getAssigned())) {
                    result.remove(s.getWeekDay());
                    redisCache.deleteCacheMapValue(key, String.valueOf(s.getWeekDay()));
                }
            }
        }
        return result;
    }

    @Override
    public String addToCart(Long studentId, Long semesterId, Long courseId) {
        checkSelectionWindow(semesterId);
        StuStudentInfo student = studentMapper.selectStudentByUserId(studentId);
        if (student == null) {
            throw new ServiceException("学生信息不存在");
        }
        if (student.getClassId() == null) {
            throw new ServiceException("您尚未分配班级，无法选课");
        }

        CouCourse course = courseMapper.selectCourseById(courseId);
        if (course == null) {
            throw new ServiceException("课程不存在");
        }
        if (!semesterId.equals(course.getSemesterId())) {
            throw new ServiceException("课程不属于当前学期");
        }
        if (course.getGradeId() != null && student.getGradeId() != null
                && !course.getGradeId().equals(student.getGradeId())) {
            throw new ServiceException("课程仅限本年级学生选课");
        }

        if (selectionMapper.countByStudentAndCourse(studentId, courseId) > 0) {
            throw new ServiceException("您已选过该课程");
        }
        if (selectionMapper.countByStudentSemesterWeekDay(studentId, semesterId, course.getWeekDay()) > 0) {
            throw new ServiceException("您在该星期已有其他选课");
        }

        CouClassQuota quota = quotaMapper.selectByCourseAndClass(courseId, student.getClassId());
        if (quota == null) {
            throw new ServiceException("该课程未对您所在班级开放");
        }
        if (quota.getSelected() != null && quota.getQuota() != null
                && quota.getSelected() >= quota.getQuota()) {
            throw new ServiceException("您所在班级名额已满");
        }

        String key = cartKey(studentId, semesterId);
        String weekKey = String.valueOf(course.getWeekDay());
        CartItemVO existing = redisCache.getCacheMapValue(key, weekKey);
        if (existing != null) {
            throw new ServiceException("选课车中该星期已有课程，请先移除再添加");
        }

        CartItemVO item = new CartItemVO();
        item.setCourseId(course.getId());
        item.setCourseName(course.getCourseName());
        item.setWeekDay(course.getWeekDay());
        item.setClassId(student.getClassId());
        item.setClassName(student.getClassName());
        item.setTeacherName(course.getTeacherName());
        item.setSemesterId(semesterId);

        redisCache.setCacheMapValue(key, weekKey, item);
        redisCache.expire(key, CART_EXPIRE_MINUTES * 60);

        return "已加入选课车";
    }

    @Override
    public void addToCartAssigned(Long studentId, Long semesterId, Long courseId) {
        StuStudentInfo student = studentMapper.selectStudentByUserId(studentId);
        if (student == null || student.getClassId() == null) {
            return;
        }
        CouCourse course = courseMapper.selectCourseById(courseId);
        if (course == null) {
            return;
        }
        String key = cartKey(studentId, semesterId);
        String weekKey = String.valueOf(course.getWeekDay());
        CartItemVO item = new CartItemVO();
        item.setCourseId(course.getId());
        item.setCourseName(course.getCourseName());
        item.setWeekDay(course.getWeekDay());
        item.setClassId(student.getClassId());
        item.setClassName(student.getClassName());
        item.setTeacherName(course.getTeacherName());
        item.setSemesterId(semesterId);
        item.setAssigned(true);
        redisCache.setCacheMapValue(key, weekKey, item);
        redisCache.expire(key, CART_EXPIRE_MINUTES * 60);
    }

    @Override
    public void removeFromCart(Long studentId, Long semesterId, Integer weekDay) {
        String key = cartKey(studentId, semesterId);
        CartItemVO item = redisCache.getCacheMapValue(key, String.valueOf(weekDay));
        if (item != null && Boolean.TRUE.equals(item.getAssigned())) {
            throw new ServiceException("该课程为管理员指定，不可移除");
        }
        redisCache.deleteCacheMapValue(key, String.valueOf(weekDay));
    }

    @Override
    public void clearCart(Long studentId, Long semesterId) {
        String key = cartKey(studentId, semesterId);
        Map<String, CartItemVO> raw = redisCache.getCacheMap(key);
        if (raw != null && !raw.isEmpty()) {
            for (Map.Entry<String, CartItemVO> e : raw.entrySet()) {
                if (!Boolean.TRUE.equals(e.getValue().getAssigned())) {
                    redisCache.deleteCacheMapValue(key, e.getKey());
                }
            }
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String submitSelection(Long studentId, Long semesterId) {
        checkSelectionWindow(semesterId);
        String lockKey = submitLockKey(studentId, semesterId);
        Boolean locked = redisCache.setIfAbsent(lockKey, "1", SUBMIT_LOCK_SECONDS, TimeUnit.SECONDS);
        if (!Boolean.TRUE.equals(locked)) {
            throw new ServiceException("操作过于频繁，请稍后再试");
        }
        try {
            Map<Integer, CartItemVO> cart = getCart(studentId, semesterId);
            List<MySelectionVO> existingSelections = selectionMapper.selectMySelections(studentId, semesterId);

            // 合并已选课程与选课车：周一到周五每天只能有一门课程
            Map<Integer, CartItemVO> merged = buildMergedSelection(cart, existingSelections);
            if (merged.size() != 5) {
                throw new ServiceException("需满足周一到周五每天一门课程才能提交，当前缺少：" + missingDays(merged));
            }

            StuStudentInfo student = studentMapper.selectStudentByUserId(studentId);
            if (student == null || student.getClassId() == null) {
                throw new ServiceException("学生信息或班级不存在");
            }

            Map<Integer, MySelectionVO> existingByDay = new HashMap<>();
            if (existingSelections != null) {
                for (MySelectionVO s : existingSelections) {
                    if (s.getWeekDay() != null) {
                        existingByDay.put(s.getWeekDay(), s);
                    }
                }
            }

            for (int d = 1; d <= 5; d++) {
                CartItemVO item = merged.get(d);
                if (item == null) {
                    throw new ServiceException("选课数据异常");
                }
                // 若该天已有选课记录，则跳过插入（补选场景）
                if (existingByDay.containsKey(d)) {
                    continue;
                }
                int updated = quotaMapper.incrementSelectedIfAvailable(item.getCourseId(), item.getClassId());
                if (updated == 0) {
                    throw new ServiceException("课程《" + item.getCourseName() + "》您所在班级名额已满，请刷新后重选");
                }

                StuSelection sel = new StuSelection();
                sel.setStudentId(studentId);
                sel.setCourseId(item.getCourseId());
                sel.setSemesterId(semesterId);
                sel.setWeekDay(d);
                sel.setClassId(item.getClassId());
                sel.setStatus(1);
                selectionMapper.insertSelection(sel);
            }

            clearCart(studentId, semesterId);
            return "选课成功";
        } finally {
            redisCache.deleteObject(lockKey);
        }
    }

    /**
     * 合并已选课程与选课车：优先使用选课车，选课车没有的用已选课程。
     * 满足周一到周五每天最多一门课程的要求。
     */
    private Map<Integer, CartItemVO> buildMergedSelection(Map<Integer, CartItemVO> cart,
            List<MySelectionVO> existingSelections) {
        Map<Integer, CartItemVO> merged = new HashMap<>();
        Map<Integer, CartItemVO> existingByDay = new HashMap<>();
        if (existingSelections != null) {
            for (MySelectionVO s : existingSelections) {
                if (s.getWeekDay() != null) {
                    CartItemVO vo = new CartItemVO();
                    vo.setCourseId(s.getCourseId());
                    vo.setCourseName(s.getCourseName());
                    vo.setWeekDay(s.getWeekDay());
                    vo.setClassId(s.getClassId());
                    vo.setClassName(s.getClassName());
                    vo.setTeacherName(s.getTeacherName());
                    vo.setSemesterId(s.getSemesterId());
                    existingByDay.put(s.getWeekDay(), vo);
                }
            }
        }
        for (int d = 1; d <= 5; d++) {
            CartItemVO item = cart != null ? cart.get(d) : null;
            if (item != null) {
                merged.put(d, item);
            } else if (existingByDay.containsKey(d)) {
                merged.put(d, existingByDay.get(d));
            }
        }
        return merged;
    }

    private String missingDays(Map<Integer, CartItemVO> cart) {
        String[] days = { "周一", "周二", "周三", "周四", "周五" };
        StringBuilder sb = new StringBuilder();
        for (int d = 1; d <= 5; d++) {
            if (!cart.containsKey(d)) {
                if (sb.length() > 0)
                    sb.append("、");
                sb.append(days[d - 1]);
            }
        }
        return sb.toString();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> dropCourse(Long studentId, Long selectionId) {
        StuSelection sel = selectionMapper.selectById(selectionId);
        if (sel == null) {
            throw new ServiceException("选课记录不存在");
        }
        if (!studentId.equals(sel.getStudentId())) {
            throw new ServiceException("无权操作此选课记录");
        }
        if (sel.getStatus() != null && sel.getStatus() == 0) {
            throw new ServiceException("该课程已退选");
        }
        if (Integer.valueOf(1).equals(sel.getAssigned())) {
            throw new ServiceException("该课程为管理员指定，不可退选");
        }

        Long semesterId = sel.getSemesterId();
        StuStudentInfo student = studentMapper.selectStudentByUserId(studentId);
        if (student == null) {
            throw new ServiceException("学生信息不存在");
        }

        // 1. 所有已选课程先退回到选课车（assigned 的保持 assigned 标记）
        List<MySelectionVO> allSelections = selectionMapper.selectMySelections(studentId, semesterId);
        String key = cartKey(studentId, semesterId);
        redisCache.deleteObject(key);
        if (allSelections != null) {
            for (MySelectionVO s : allSelections) {
                CouCourse course = courseMapper.selectCourseById(s.getCourseId());
                if (course != null) {
                    CartItemVO item = new CartItemVO();
                    item.setCourseId(course.getId());
                    item.setCourseName(course.getCourseName());
                    item.setWeekDay(course.getWeekDay());
                    item.setClassId(s.getClassId() != null ? s.getClassId() : student.getClassId());
                    item.setClassName(student.getClassName());
                    item.setTeacherName(course.getTeacherName());
                    item.setSemesterId(semesterId);
                    item.setAssigned(Integer.valueOf(1).equals(s.getAssigned()));
                    String weekKey = String.valueOf(course.getWeekDay());
                    redisCache.setCacheMapValue(key, weekKey, item);
                }
            }
        }
        // 2. 在选课车中移除要退选的课程
        if (sel.getWeekDay() != null) {
            redisCache.deleteCacheMapValue(key, String.valueOf(sel.getWeekDay()));
        }
        redisCache.expire(key, CART_EXPIRE_MINUTES * 60);

        // 3. 移出选课记录（逻辑删除 + 回退名额）
        selectionMapper.updateStatus(selectionId, 0);
        if (sel.getClassId() != null) {
            quotaMapper.decrementSelected(sel.getCourseId(), sel.getClassId());
        }

        // 4. 返回更新后的选课车，供前端直接更新
        Map<Integer, CartItemVO> cart = getCart(studentId, semesterId);
        Map<String, Object> result = new HashMap<>();
        result.put("msg", "退课成功，其余课程已放回选课车，请补选后提交");
        result.put("cart", cart);
        return result;
    }

    @Override
    public List<MySelectionVO> getMySelections(Long studentId, Long semesterId) {
        return selectionMapper.selectMySelections(studentId, semesterId);
    }

    @Override
    public Map<Long, Integer> getRemainingQuota(Long courseId) {
        List<CouClassQuota> list = quotaMapper.selectQuotaByCourseId(courseId);
        Map<Long, Integer> result = new HashMap<>();
        for (CouClassQuota q : list) {
            if (q.getClassId() != null && q.getQuota() != null && q.getSelected() != null) {
                int remain = Math.max(0, q.getQuota() - q.getSelected());
                result.put(q.getClassId(), remain);
            }
        }
        return result;
    }
}
