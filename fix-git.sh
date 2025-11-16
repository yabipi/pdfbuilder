#!/bin/bash

# 修复 Git 大文件问题，确保能成功提交

set -e

echo "=========================================="
echo "修复 Git 提交问题"
echo "=========================================="
echo ""

# 1. 确保 .gitignore 包含 release/
echo "步骤 1: 更新 .gitignore..."
if [ ! -f ".gitignore" ]; then
    touch .gitignore
fi

if ! grep -q "^release/" .gitignore && ! grep -q "^release$" .gitignore; then
    echo "release/" >> .gitignore
    echo "✓ 已添加 release/ 到 .gitignore"
else
    echo "✓ release/ 已在 .gitignore 中"
fi

echo ""
echo ".gitignore 内容:"
cat .gitignore
echo ""

# 2. 从 Git 跟踪中移除 release 目录（如果已跟踪）
echo "步骤 2: 从 Git 跟踪中移除 release 目录..."
if git ls-files | grep -q "^release/"; then
    git rm -r --cached release/ 2>/dev/null || true
    echo "✓ 已从 Git 跟踪中移除 release 目录"
else
    echo "✓ release 目录未在 Git 跟踪中"
fi

# 3. 添加 .gitignore
echo ""
echo "步骤 3: 添加 .gitignore..."
git add .gitignore
echo "✓ .gitignore 已添加到暂存区"

# 4. 显示状态
echo ""
echo "当前 Git 状态:"
git status --short

echo ""
echo "=========================================="
echo "✓ 修复完成！"
echo "=========================================="
echo ""
echo "现在可以提交了:"
echo "  git commit -m 'Fix: Add release/ to .gitignore'"
echo "  git push origin master"
echo ""

