#!/bin/bash

echo "🚀 网络安全项目 - GitHub推送脚本"
echo "=================================="
echo ""

# 检查是否有未提交的更改
if [[ `git status --porcelain` ]]; then
  echo "⚠️  检测到未提交的更改："
  git status --short
  echo ""
  read -p "是否先提交这些更改? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "请输入提交信息: " commit_msg
    git add -A
    git commit -m "$commit_msg"
  else
    echo "❌ 取消推送"
    exit 1
  fi
fi

echo ""
echo "📋 当前远程仓库："
git remote -v
echo ""

read -p "是否推送到以上仓库? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "❌ 取消推送"
  exit 1
fi

echo ""
echo "📤 正在推送到 GitHub..."
git push origin main

if [ $? -eq 0 ]; then
  echo ""
  echo "✅ 推送成功！"
  echo ""
  echo "🔗 访问你的GitHub仓库查看："
  git remote get-url origin | sed 's/\.git$//'
else
  echo ""
  echo "❌ 推送失败"
  echo ""
  echo "💡 可能的解决方案："
  echo "1. 检查网络连接"
  echo "2. 确认GitHub账号权限"
  echo "3. 尝试使用 SSH: git remote set-url origin git@github.com:用户名/仓库名.git"
  echo "4. 查看详细文档: cat GITHUB_PUSH_GUIDE.md"
fi
