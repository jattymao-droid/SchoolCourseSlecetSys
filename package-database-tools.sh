#!/bin/bash

# ============================================
# 数据库工具打包脚本
# ============================================
# 用途：将所有数据库管理工具打包，方便上传到服务器
# ============================================

echo "=========================================="
echo "数据库工具打包脚本"
echo "=========================================="
echo ""

# 创建临时目录
TEMP_DIR="database-tools-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$TEMP_DIR"

echo "正在收集文件..."

# 复制脚本文件
SCRIPTS=(
    "diagnose-database-server.sh"
    "auto-fix-database-server.sh"
    "manage-database-server.sh"
    "clean-database-server.sh"
    "clean-deleted-records-server.sh"
)

for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        cp "$script" "$TEMP_DIR/"
        echo "✓ $script"
    else
        echo "⚠ 未找到: $script"
    fi
done

# 复制文档文件
DOCS=(
    "数据库工具-README.md"
    "服务器数据库工具集说明.md"
    "数据库管理工具使用说明.md"
    "服务器数据库清理说明.md"
    "数据库问题快速解决指南.md"
    "fix-database-name.md"
)

for doc in "${DOCS[@]}"; do
    if [ -f "$doc" ]; then
        cp "$doc" "$TEMP_DIR/"
        echo "✓ $doc"
    else
        echo "⚠ 未找到: $doc"
    fi
done

echo ""
echo "正在打包..."

# 创建压缩包
tar -czf "${TEMP_DIR}.tar.gz" "$TEMP_DIR"

# 清理临时目录
rm -rf "$TEMP_DIR"

echo ""
echo "=========================================="
echo "打包完成！"
echo "=========================================="
echo ""
echo "压缩包: ${TEMP_DIR}.tar.gz"
echo "大小: $(du -h "${TEMP_DIR}.tar.gz" | cut -f1)"
echo ""
echo "上传到服务器："
echo "  scp ${TEMP_DIR}.tar.gz root@your-server:/root/"
echo ""
echo "在服务器上解压："
echo "  tar -xzf ${TEMP_DIR}.tar.gz"
echo "  cd ${TEMP_DIR}"
echo "  chmod +x *.sh"
echo "  ./diagnose-database-server.sh"
echo ""
