# 部署说明

## 添加 .nojekyll 文件

`.nojekyll` 文件已创建，用于禁用 Jekyll，允许 GitHub Pages 访问 `_next` 目录。

## 提交和推送步骤

```bash
cd /Users/ku/workspaces/PDFUtils/pdfbuilder-doc

# 添加 .nojekyll 文件
git add .nojekyll

# 提交
git commit -m "Add .nojekyll to disable Jekyll for _next directory"

# 推送到 GitHub
git push
```

推送后，等待 1-2 分钟让 GitHub Pages 更新，然后刷新页面即可。

