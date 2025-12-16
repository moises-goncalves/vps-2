#!/bin/bash

################################################################################
# GitHub 仓库设置自动化脚本
#
# 功能：自动为两个GitHub仓库设置描述和话题标签
# 作者：梓铭
# 日期：2025-11-23
#
# 使用方法：
#   1. 确保已安装 GitHub CLI: brew install gh
#   2. 登录 GitHub CLI: gh auth login
#   3. 运行脚本: bash setup_github_repos.sh
################################################################################

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印函数
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo ""
}

################################################################################
# 检查依赖
################################################################################

check_dependencies() {
    print_header "检查依赖"

    # 检查 gh 是否安装
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) 未安装"
        print_info "请运行: brew install gh"
        exit 1
    fi
    print_success "GitHub CLI 已安装"

    # 检查是否已登录
    if ! gh auth status &> /dev/null; then
        print_error "未登录 GitHub CLI"
        print_info "请运行: gh auth login"
        exit 1
    fi
    print_success "GitHub CLI 已登录"
}

################################################################################
# 设置 Network-Security-Based-On-ML 仓库
################################################################################

setup_network_security_repo() {
    print_header "设置 Network-Security-Based-On-ML 仓库"

    REPO="zimingttkx/Network-Security-Based-On-ML"

    # 设置描述
    print_info "设置仓库描述..."
    DESCRIPTION="基于机器学习的智能网络安全威胁检测系统 | 支持30+特征分析、AutoML自动调优、实时预测 | FastAPI + WebSocket + MLflow | 完整的数据验证和特征补全功能"

    if gh repo edit "$REPO" --description "$DESCRIPTION"; then
        print_success "描述设置成功"
    else
        print_error "描述设置失败"
        return 1
    fi

    # 添加话题标签
    print_info "添加话题标签..."

    TOPICS=(
        "machine-learning"
        "network-security"
        "cybersecurity"
        "threat-detection"
        "fastapi"
        "python"
        "scikit-learn"
        "xgboost"
        "lightgbm"
        "catboost"
        "mlflow"
        "automl"
        "websocket"
        "docker"
        "kubernetes"
        "intrusion-detection"
        "phishing-detection"
        "feature-engineering"
        "data-imputation"
        "real-time-prediction"
    )

    for topic in "${TOPICS[@]}"; do
        if gh repo edit "$REPO" --add-topic "$topic" 2>/dev/null; then
            print_success "添加话题: $topic"
        else
            print_warning "话题已存在或添加失败: $topic"
        fi
    done

    print_success "Network-Security-Based-On-ML 仓库设置完成"
    echo ""
    print_info "仓库地址: https://github.com/$REPO"
}

################################################################################
# 设置 NUFELibrary 仓库
################################################################################

setup_nufe_library_repo() {
    print_header "设置 NUFELibrary 仓库"

    REPO="zimingttkx/NUFELibrary"

    # 设置描述
    print_info "设置仓库描述..."
    DESCRIPTION="东北财经大学图书馆座位预约自动化系统 | 智能抢座、自动签到、定时预约 | 支持多账号管理、邮件通知 | Python + Selenium + Flask"

    if gh repo edit "$REPO" --description "$DESCRIPTION"; then
        print_success "描述设置成功"
    else
        print_error "描述设置失败"
        return 1
    fi

    # 添加话题标签
    print_info "添加话题标签..."

    TOPICS=(
        "automation"
        "seat-reservation"
        "library-system"
        "python"
        "selenium"
        "flask"
        "web-automation"
        "nufe"
        "university"
        "student-tools"
        "booking-system"
        "scheduled-tasks"
        "notification-system"
        "web-scraping"
    )

    for topic in "${TOPICS[@]}"; do
        if gh repo edit "$REPO" --add-topic "$topic" 2>/dev/null; then
            print_success "添加话题: $topic"
        else
            print_warning "话题已存在或添加失败: $topic"
        fi
    done

    print_success "NUFELibrary 仓库设置完成"
    echo ""
    print_info "仓库地址: https://github.com/$REPO"
}

################################################################################
# 显示设置结果
################################################################################

show_results() {
    print_header "设置完成总结"

    echo "✅ 已完成的设置："
    echo ""
    echo "1. Network-Security-Based-On-ML"
    echo "   - 仓库描述：已更新"
    echo "   - 话题标签：已添加 20 个"
    echo "   - 访问地址：https://github.com/zimingttkx/Network-Security-Based-On-ML"
    echo ""
    echo "2. NUFELibrary"
    echo "   - 仓库描述：已更新"
    echo "   - 话题标签：已添加 14 个"
    echo "   - 访问地址：https://github.com/zimingttkx/NUFELibrary"
    echo ""

    print_info "接下来您可以："
    echo "  • 访问仓库查看效果"
    echo "  • 在 Settings → About 中进一步调整"
    echo "  • 添加仓库社交预览图 (1280x640px)"
    echo "  • 启用 Wikis、Issues、Discussions 等功能"
    echo ""
}

################################################################################
# 主函数
################################################################################

main() {
    clear

    print_header "GitHub 仓库自动设置脚本"

    echo "此脚本将为以下仓库设置描述和话题标签："
    echo "  1. zimingttkx/Network-Security-Based-On-ML"
    echo "  2. zimingttkx/NUFELibrary"
    echo ""

    read -p "是否继续？(y/n) " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "用户取消操作"
        exit 0
    fi

    # 检查依赖
    check_dependencies

    # 设置仓库
    setup_network_security_repo
    setup_nufe_library_repo

    # 显示结果
    show_results

    print_success "所有操作完成！"
}

################################################################################
# 执行主函数
################################################################################

main "$@"
