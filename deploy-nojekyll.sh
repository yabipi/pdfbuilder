#!/bin/bash

# 部署 .nojekyll 文件到 GitHub

cd "$(dirname "$0")"

echo "=========================================="
echo "部署 .nojekyll 文件"
echo "=========================================="
echo ""

# 检查是否是 Git 仓库
if [ ! -d ".git" ]; then
    echo "❌ 错误: 当前目录不是 Git 仓库"
    echo "请先初始化 Git 仓库或确认目录正确"
    exit 1
fi

# 检查 .nojekyll 文件
if [ ! -f ".nojekyll" ]; then
    echo "创建 .nojekyll 文件..."
    touch .nojekyll
fi

echo "✓ .nojekyll 文件已存在"
echo ""

# 添加文件
echo "添加 .nojekyll 到 Git..."
git add .nojekyll

# 检查是否有变更
if git diff --cached --quiet; then
    echo "⚠️  没有变更需要提交（文件可能已经提交过了）"
    echo ""
    echo "检查 Git 状态:"
    git status --short
else
    echo "✓ 文件已添加到暂存区"
    echo ""
    
    # 提交
    echo "提交变更..."
    git commit -m "Add .nojekyll to disable Jekyll for _next directory"
    echo "✓ 已提交"
    echo ""
    
    # 推送
    echo "推送到 GitHub..."
    git push
    echo ""
    echo "✅ 完成！.nojekyll 文件已推送到 GitHub"
    echo ""
    echo "请等待 1-2 分钟让 GitHub Pages 更新，然后刷新页面。"
fi

