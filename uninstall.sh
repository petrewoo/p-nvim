#!/bin/bash

# P-Nvim 卸载/清理脚本

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
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

# 打印横幅
print_banner() {
    cat << 'EOF'
================================================
    P-Nvim 卸载/清理工具
================================================
EOF
}

# 显示菜单
show_menu() {
    echo
    echo "请选择操作："
    echo
    echo "1) 完全卸载 (删除配置和所有数据)"
    echo "2) 只删除配置文件 (保留插件和缓存)"
    echo "3) 只清理缓存和插件 (保留配置)"
    echo "4) 清理插件缓存 (保留配置和数据)"
    echo "5) 重置为初始状态 (重新安装)"
    echo "6) 清理 Shell SDK 配置 (仅清理 P-Nvim 添加的 SDK 设置)"
    echo "7) 显示当前占用空间"
    echo "0) 退出"
    echo
}

# 获取目录大小
get_dir_size() {
    if [ -d "$1" ]; then
        du -sh "$1" 2>/dev/null | cut -f1
    else
        echo "不存在"
    fi
}

# 显示占用空间
show_disk_usage() {
    print_info "P-Nvim 文件占用空间："
    echo
    echo "配置文件:     $(get_dir_size ~/.config/nvim)"
    echo "插件数据:     $(get_dir_size ~/.local/share/nvim)"
    echo "缓存文件:     $(get_dir_size ~/.cache/nvim)"
    echo "状态文件:     $(get_dir_size ~/.local/state/nvim)"
    echo

    # 计算总大小
    local total=0
    for dir in ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim; do
        if [ -d "$dir" ]; then
            local size=$(du -sk "$dir" 2>/dev/null | cut -f1)
            total=$((total + size))
        fi
    done

    # 转换为人类可读格式
    if [ $total -gt 1048576 ]; then
        echo "总计: $((total / 1048576)) GB"
    elif [ $total -gt 1024 ]; then
        echo "总计: $((total / 1024)) MB"
    else
        echo "总计: ${total} KB"
    fi
}

# 备份配置
backup_config() {
    local backup_name="nvim-backup-$(date +%Y%m%d_%H%M%S)"
    local backup_dir="$HOME/$backup_name"

    print_info "备份配置到: $backup_dir"
    mkdir -p "$backup_dir"

    [ -d ~/.config/nvim ] && cp -r ~/.config/nvim "$backup_dir/config"
    [ -d ~/.local/share/nvim ] && cp -r ~/.local/share/nvim "$backup_dir/share"
    [ -d ~/.local/state/nvim ] && cp -r ~/.local/state/nvim "$backup_dir/state"

    print_success "备份完成: $backup_dir"
}

# 清理 Shell 配置中的 SDK 设置
clean_sdk_config() {
    print_info "检查 Shell 配置中的 SDK 设置..."

    # 确定 shell 配置文件
    local shell_configs=()
    [ -f ~/.zshrc ] && shell_configs+=("$HOME/.zshrc")
    [ -f ~/.bashrc ] && shell_configs+=("$HOME/.bashrc")
    [ -f ~/.profile ] && shell_configs+=("$HOME/.profile")

    local cleaned=0
    for config in "${shell_configs[@]}"; do
        # 检查是否有 P-Nvim 添加的 SDK 配置
        if grep -q "# P-Nvim.*SDK" "$config" 2>/dev/null; then
            print_info "在 $config 中发现 P-Nvim SDK 配置"
            read -p "是否要移除? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                # 移除 P-Nvim 添加的 SDK 配置块
                # 匹配从 "# P-Nvim.*SDK" 到 "# END P-Nvim SDK Config" 的整个块
                sed -i.bak '/# P-Nvim.*SDK/,/# END P-Nvim SDK Config/d' "$config"

                # 也移除可能在 SDKROOT 行后添加的 CPATH 注释
                sed -i.bak '/# P-Nvim: for Neovim plugins compilation/d' "$config"

                rm -f "${config}.bak"
                print_success "已从 $config 移除 SDK 配置"
                cleaned=1
            fi
        fi
    done

    if [ $cleaned -eq 0 ]; then
        print_info "未发现 P-Nvim 添加的 SDK 配置"
    else
        print_info "SDK 配置已清理，建议重新打开终端使更改生效"
    fi
}

# 完全卸载
full_uninstall() {
    print_warning "这将删除所有 P-Nvim 相关文件！"
    read -p "是否要备份配置? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        backup_config
    fi

    print_warning "即将删除以下目录："
    echo "  - ~/.config/nvim"
    echo "  - ~/.local/share/nvim"
    echo "  - ~/.cache/nvim"
    echo "  - ~/.local/state/nvim"
    echo

    read -p "确定要继续吗? (输入 'yes' 确认): " confirm
    if [ "$confirm" != "yes" ]; then
        print_info "取消操作"
        return
    fi

    print_info "开始卸载..."

    rm -rf ~/.config/nvim
    print_success "删除配置目录"

    rm -rf ~/.local/share/nvim
    print_success "删除数据目录"

    rm -rf ~/.cache/nvim
    print_success "删除缓存目录"

    rm -rf ~/.local/state/nvim
    print_success "删除状态目录"

    # 清理 SDK 配置
    echo
    clean_sdk_config

    print_success "P-Nvim 已完全卸载！"
}

# 只删除配置
remove_config_only() {
    print_warning "这将删除配置文件，但保留插件和缓存"

    read -p "是否要备份配置? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        backup_config
    fi

    read -p "确定要继续吗? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "取消操作"
        return
    fi

    rm -rf ~/.config/nvim
    print_success "配置文件已删除"
}

# 清理缓存和插件
clean_cache_plugins() {
    print_info "清理缓存和插件数据..."

    read -p "确定要继续吗? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "取消操作"
        return
    fi

    rm -rf ~/.local/share/nvim
    print_success "删除插件数据"

    rm -rf ~/.cache/nvim
    print_success "删除缓存"

    rm -rf ~/.local/state/nvim
    print_success "删除状态文件"

    print_success "清理完成！下次启动 Neovim 时会重新安装插件"
}

# 只清理插件缓存
clean_plugin_cache() {
    print_info "清理插件缓存..."

    # 清理 lazy.nvim 缓存
    if [ -d ~/.local/share/nvim/lazy ]; then
        rm -rf ~/.local/share/nvim/lazy
        print_success "删除 lazy.nvim 插件"
    fi

    # 清理 Mason 缓存
    if [ -d ~/.local/share/nvim/mason ]; then
        rm -rf ~/.local/share/nvim/mason
        print_success "删除 Mason LSP 服务器"
    fi

    # 清理缓存
    if [ -d ~/.cache/nvim ]; then
        rm -rf ~/.cache/nvim
        print_success "删除缓存文件"
    fi

    print_success "插件缓存清理完成！"
    print_info "下次启动 Neovim 时会重新安装插件"
}

# 重置为初始状态
reset_to_initial() {
    print_info "重置为初始状态..."
    print_warning "这将删除所有文件并重新安装"

    read -p "是否要备份配置? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        backup_config
    fi

    read -p "确定要继续吗? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "取消操作"
        return
    fi

    # 删除所有文件
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.cache/nvim
    rm -rf ~/.local/state/nvim

    print_success "已清理所有文件"

    # 检查是否有安装脚本
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [ -f "$script_dir/install.sh" ]; then
        print_info "重新运行安装脚本..."
        read -p "按 Enter 继续安装..."
        "$script_dir/install.sh"
    else
        print_warning "未找到 install.sh，请手动重新安装"
    fi
}

# 清理特定项目
clean_specific() {
    echo
    echo "请选择要清理的项目："
    echo
    echo "1) Lazy.nvim 插件"
    echo "2) Mason LSP 服务器"
    echo "3) Treesitter 解析器"
    echo "4) 撤销历史"
    echo "5) 会话文件"
    echo "6) 日志文件"
    echo "7) 所有临时文件"
    echo "0) 返回主菜单"
    echo

    read -p "请选择 [0-7]: " choice

    case $choice in
        1)
            rm -rf ~/.local/share/nvim/lazy
            print_success "已清理 Lazy.nvim 插件"
            ;;
        2)
            rm -rf ~/.local/share/nvim/mason
            print_success "已清理 Mason LSP 服务器"
            ;;
        3)
            rm -rf ~/.local/share/nvim/site/pack/*/start/nvim-treesitter
            print_success "已清理 Treesitter 解析器"
            ;;
        4)
            rm -rf ~/.local/share/nvim/undo
            rm -rf ~/.config/nvim/undo
            print_success "已清理撤销历史"
            ;;
        5)
            rm -rf ~/.local/share/nvim/sessions
            rm -rf ~/.config/nvim/sessions
            print_success "已清理会话文件"
            ;;
        6)
            rm -f ~/.cache/nvim/*.log
            rm -f ~/.local/state/nvim/*.log
            print_success "已清理日志文件"
            ;;
        7)
            rm -rf ~/.cache/nvim/*
            rm -rf ~/.local/state/nvim/*
            print_success "已清理所有临时文件"
            ;;
        0)
            return
            ;;
        *)
            print_error "无效选择"
            ;;
    esac

    read -p "按 Enter 继续..."
}

# 主函数
main() {
    print_banner

    while true; do
        show_menu
        read -p "请选择 [0-7]: " choice

        case $choice in
            1)
                full_uninstall
                ;;
            2)
                remove_config_only
                ;;
            3)
                clean_cache_plugins
                ;;
            4)
                clean_plugin_cache
                ;;
            5)
                reset_to_initial
                ;;
            6)
                clean_sdk_config
                ;;
            7)
                show_disk_usage
                ;;
            0)
                print_info "退出"
                exit 0
                ;;
            *)
                print_error "无效选择，请输入 0-7"
                ;;
        esac

        echo
        read -p "按 Enter 继续..."
    done
}

# 运行主函数
main "$@"
