#!/bin/bash
# P-Nvim 极速安装脚本 - 适用于已有 Neovim 环境的用户

set -e

echo "================================================"
echo "  P-Nvim 极速安装"
echo "================================================"
echo

# 获取脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

# 备份现有配置
if [ -d "$NVIM_CONFIG" ]; then
    BACKUP="$NVIM_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 备份现有配置到: $BACKUP"
    mv "$NVIM_CONFIG" "$BACKUP"
fi

# 复制配置
echo "📋 复制配置文件..."
mkdir -p "$HOME/.config"
cp -r "$SCRIPT_DIR/nvim" "$NVIM_CONFIG"

echo "✅ 配置安装完成！"
echo
echo "下一步:"
echo "1. 启动 Neovim: nvim"
echo "2. 等待插件自动安装（首次启动需要几分钟）"
echo "3. 运行 :Mason 安装 LSP 服务器"
echo "4. 运行 :checkhealth 检查状态"
echo
echo "查看文档: cat $SCRIPT_DIR/QUICKSTART.md"
echo "================================================"
