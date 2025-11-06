#!/bin/bash

# P-Nvim 维护脚本 - 更新、清理、优化

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

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

print_banner() {
    cat << 'EOF'
================================================
    P-Nvim 维护工具
================================================
EOF
}

# 显示菜单
show_menu() {
    echo
    echo "维护选项："
    echo
    echo "1) 更新所有插件"
    echo "2) 清理未使用的插件"
    echo "3) 更新 LSP 服务器"
    echo "4) 检查健康状态"
    echo "5) 优化启动速度"
    echo "6) 清理缓存"
    echo "7) 备份配置"
    echo "8) 恢复配置"
    echo "9) 完整维护（推荐）"
    echo "0) 退出"
    echo
}

# 更新插件
update_plugins() {
    print_info "更新所有插件..."
    nvim --headless "+Lazy! sync" +qa
    print_success "插件更新完成"
}

# 清理插件
clean_plugins() {
    print_info "清理未使用的插件..."
    nvim --headless "+Lazy! clean" +qa
    print_success "插件清理完成"
}

# 更新 LSP 服务器
update_lsp() {
    print_info "更新 LSP 服务器..."
    nvim --headless "+MasonUpdate" +qa
    print_success "LSP 服务器更新完成"
}

# 健康检查
health_check() {
    print_info "运行健康检查..."
    echo
    nvim -c "checkhealth" -c "q"
}

# 优化启动速度
optimize_startup() {
    print_info "分析启动性能..."

    # 生成启动日志
    nvim --startuptime /tmp/nvim-startup.log +q

    echo
    print_info "启动耗时最长的前 10 个项目："
    echo
    sort -k2 -rn /tmp/nvim-startup.log | head -20 | tail -10

    echo
    print_info "完整日志: /tmp/nvim-startup.log"

    # 提供优化建议
    echo
    print_info "优化建议："
    echo "  1. 禁用不常用的插件"
    echo "  2. 使用延迟加载（lazy loading）"
    echo "  3. 减少自动命令（autocmd）"
    echo "  4. 检查 shell 配置（.bashrc/.zshrc）"
}

# 清理缓存
clean_cache() {
    print_info "清理缓存..."

    local cleaned=0

    # 清理 Neovim 缓存
    if [ -d ~/.cache/nvim ]; then
        local size=$(du -sh ~/.cache/nvim | cut -f1)
        rm -rf ~/.cache/nvim/*
        print_success "清理 Neovim 缓存: $size"
        ((cleaned++))
    fi

    # 清理日志
    if [ -d ~/.local/state/nvim ]; then
        find ~/.local/state/nvim -name "*.log" -delete 2>/dev/null && ((cleaned++))
        print_success "清理日志文件"
    fi

    # 清理撤销历史（可选）
    local undo_dir="$HOME/.local/share/nvim/undo"
    if [ -d "$undo_dir" ]; then
        local file_count=$(find "$undo_dir" -type f | wc -l)
        if [ $file_count -gt 100 ]; then
            print_warning "撤销历史文件过多 ($file_count 个)"
            read -p "是否清理 30 天前的撤销历史? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                find "$undo_dir" -type f -mtime +30 -delete
                print_success "清理旧的撤销历史"
                ((cleaned++))
            fi
        fi
    fi

    if [ $cleaned -eq 0 ]; then
        print_info "无需清理"
    else
        print_success "缓存清理完成"
    fi
}

# 备份配置
backup_config() {
    local backup_name="nvim-backup-$(date +%Y%m%d_%H%M%S)"
    local backup_dir="$HOME/nvim-backups"
    local backup_path="$backup_dir/$backup_name.tar.gz"

    print_info "备份配置..."

    mkdir -p "$backup_dir"

    # 打包配置
    tar -czf "$backup_path" \
        -C "$HOME/.config" nvim \
        2>/dev/null || true

    if [ -f "$backup_path" ]; then
        local size=$(du -sh "$backup_path" | cut -f1)
        print_success "备份完成: $backup_path ($size)"

        # 清理旧备份（保留最近 5 个）
        local backup_count=$(ls -1 "$backup_dir" | wc -l)
        if [ $backup_count -gt 5 ]; then
            print_info "清理旧备份..."
            cd "$backup_dir"
            ls -t | tail -n +6 | xargs rm -f
            print_success "已清理 $((backup_count - 5)) 个旧备份"
        fi
    else
        print_error "备份失败"
    fi
}

# 恢复配置
restore_config() {
    local backup_dir="$HOME/nvim-backups"

    if [ ! -d "$backup_dir" ] || [ -z "$(ls -A "$backup_dir")" ]; then
        print_error "未找到备份文件"
        return
    fi

    print_info "可用的备份："
    echo

    local backups=($(ls -t "$backup_dir"))
    local i=1
    for backup in "${backups[@]}"; do
        local size=$(du -sh "$backup_dir/$backup" | cut -f1)
        echo "$i) $backup ($size)"
        ((i++))
    done

    echo
    read -p "请选择要恢复的备份 [1-${#backups[@]}]: " choice

    if [[ ! $choice =~ ^[0-9]+$ ]] || [ $choice -lt 1 ] || [ $choice -gt ${#backups[@]} ]; then
        print_error "无效选择"
        return
    fi

    local selected="${backups[$((choice-1))]}"
    local backup_path="$backup_dir/$selected"

    print_warning "这将覆盖当前配置！"
    read -p "确定要继续吗? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "取消操作"
        return
    fi

    # 备份当前配置
    if [ -d ~/.config/nvim ]; then
        mv ~/.config/nvim ~/.config/nvim.before-restore
        print_info "当前配置已移至: ~/.config/nvim.before-restore"
    fi

    # 恢复备份
    tar -xzf "$backup_path" -C "$HOME/.config"
    print_success "配置已恢复"
}

# 完整维护
full_maintenance() {
    print_info "开始完整维护..."
    echo

    print_info "步骤 1/5: 更新插件"
    update_plugins
    echo

    print_info "步骤 2/5: 清理未使用的插件"
    clean_plugins
    echo

    print_info "步骤 3/5: 更新 LSP 服务器"
    update_lsp
    echo

    print_info "步骤 4/5: 清理缓存"
    clean_cache
    echo

    print_info "步骤 5/5: 备份配置"
    backup_config
    echo

    print_success "完整维护完成！"
    echo
    print_info "建议重启 Neovim 以应用更改"
}

# 显示统计信息
show_stats() {
    echo
    print_info "P-Nvim 统计信息："
    echo

    # 配置大小
    if [ -d ~/.config/nvim ]; then
        local config_size=$(du -sh ~/.config/nvim | cut -f1)
        echo "配置文件: $config_size"
    fi

    # 插件数量
    if [ -d ~/.local/share/nvim/lazy ]; then
        local plugin_count=$(ls -1 ~/.local/share/nvim/lazy | wc -l)
        local plugin_size=$(du -sh ~/.local/share/nvim/lazy | cut -f1)
        echo "插件: $plugin_count 个 ($plugin_size)"
    fi

    # LSP 服务器
    if [ -d ~/.local/share/nvim/mason/packages ]; then
        local lsp_count=$(ls -1 ~/.local/share/nvim/mason/packages | wc -l)
        local lsp_size=$(du -sh ~/.local/share/nvim/mason | cut -f1)
        echo "LSP 服务器: $lsp_count 个 ($lsp_size)"
    fi

    # 缓存大小
    if [ -d ~/.cache/nvim ]; then
        local cache_size=$(du -sh ~/.cache/nvim | cut -f1)
        echo "缓存: $cache_size"
    fi

    # 撤销历史
    if [ -d ~/.local/share/nvim/undo ]; then
        local undo_count=$(find ~/.local/share/nvim/undo -type f | wc -l)
        local undo_size=$(du -sh ~/.local/share/nvim/undo | cut -f1)
        echo "撤销历史: $undo_count 个文件 ($undo_size)"
    fi

    # 备份
    if [ -d ~/nvim-backups ]; then
        local backup_count=$(ls -1 ~/nvim-backups | wc -l)
        local backup_size=$(du -sh ~/nvim-backups | cut -f1)
        echo "备份: $backup_count 个 ($backup_size)"
    fi

    echo
}

# 主函数
main() {
    print_banner
    show_stats

    while true; do
        show_menu
        read -p "请选择 [0-9]: " choice

        case $choice in
            1)
                update_plugins
                ;;
            2)
                clean_plugins
                ;;
            3)
                update_lsp
                ;;
            4)
                health_check
                ;;
            5)
                optimize_startup
                ;;
            6)
                clean_cache
                ;;
            7)
                backup_config
                ;;
            8)
                restore_config
                ;;
            9)
                full_maintenance
                ;;
            0)
                print_info "退出"
                exit 0
                ;;
            *)
                print_error "无效选择"
                ;;
        esac

        echo
        read -p "按 Enter 继续..."
    done
}

# 运行主函数
main "$@"
