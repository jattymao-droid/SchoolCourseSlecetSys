import dayjs from 'dayjs'
import customParseFormat from 'dayjs/plugin/customParseFormat'
import utc from 'dayjs/plugin/utc'
import timezone from 'dayjs/plugin/timezone'

dayjs.extend(customParseFormat)
dayjs.extend(utc)
dayjs.extend(timezone)

/** 后端 @JsonFormat(timezone="GMT+8") 返回东八区时间，如 "2026-03-03 00:10:52" */
const TZ = 'Asia/Shanghai'
const FORMAT = 'YYYY-MM-DD HH:mm:ss'

/** 从学期对象获取选课开始/结束时间（兼容 camelCase、snake_case、时间戳） */
export function getSelectionTimes(sem: Record<string, unknown> | null | undefined) {
  if (!sem || typeof sem !== 'object') return { start: null, end: null }
  const startVal = sem.selectionStartTime ?? sem.selection_start_time
  const endVal = sem.selectionEndTime ?? sem.selection_end_time
  return {
    start: parseSelectionTime(startVal),
    end: parseSelectionTime(endVal)
  }
}

const FORMATS = [
  FORMAT,
  'YYYY-MM-DD HH:mm:ss.S',
  'YYYY-MM-DD HH:mm:ss.SS',
  'YYYY-MM-DD HH:mm:ss.SSS',
  'YYYY-MM-DDTHH:mm:ss',
  'YYYY-MM-DDTHH:mm:ss.SSS',
  'YYYY/MM/DD HH:mm:ss'
]

/**
 * 解析选课时间。后端返回东八区时间字符串，必须按东八区解析，否则非中国时区用户会出错。
 */
export function parseSelectionTime(val: unknown): dayjs.Dayjs | null {
  if (val == null || val === '') return null
  if (typeof val === 'number') {
    const ms = val < 10000000000 ? val * 1000 : val
    const d = dayjs(ms)
    return d.isValid() ? d : null
  }
  const str = String(val).trim()
  if (!str) return null
  for (const fmt of FORMATS) {
    const d = dayjs.tz(str, fmt, TZ)
    if (d.isValid()) return d
  }
  return null
}

/** 当前时刻（Unix 时间戳与解析结果一致，可正确比较） */
export function nowInShanghai() {
  return dayjs()
}
