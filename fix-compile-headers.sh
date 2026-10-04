#!/bin/bash

# 修复 macOS Sequoia SDK 头文件问题
# 用于解决 nvim-treesitter 和其他插件编译失败

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
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

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}  修复 Neovim 插件编译问题${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo

# 检查 SDK 路径
print_info "检查 SDK 配置..."

# 用 xcrun 检测当前生效的 SDK。先清掉继承来的旧值：xcrun 会原样返回已有的 SDKROOT。
unset SDKROOT CPATH
SDK_PATH="$(xcrun --show-sdk-path 2>/dev/null)"
if [ -d "$SDK_PATH" ]; then
    print_success "找到 SDK: $SDK_PATH"
else
    print_error "未找到可用的 macOS SDK"
    print_info "请运行: xcode-select --install"
    exit 1
fi

# 设置环境变量并重新编译
print_info "设置编译环境变量..."

export SDKROOT="$SDK_PATH"
export CPATH="$SDK_PATH/usr/include"
export CPPFLAGS="-isysroot $SDK_PATH"
export LDFLAGS="-L$SDK_PATH/usr/lib"

print_success "环境变量已设置"
echo "  SDKROOT=$SDKROOT"
echo "  CPATH=$CPATH"

# 清理之前的编译失败
print_info "清理之前的编译文件..."
rm -rf ~/.local/share/nvim/lazy/telescope-fzf-native.nvim/build
rm -rf ~/.local/share/nvim/lazy/LuaSnip/deps/jsregexp/*.o

# 启动 Neovim 并重新编译插件
print_info "启动 Neovim 重新编译插件..."
echo
print_warning "这可能需要几分钟时间，请耐心等待..."
echo

SDKROOT="$SDK_PATH" \
CPATH="$SDK_PATH/usr/include" \
CPPFLAGS="-isysroot $SDK_PATH" \
LDFLAGS="-L$SDK_PATH/usr/lib" \
nvim --headless "+Lazy! sync" +qa

echo
print_success "编译完成！"
echo
print_info "现在可以正常使用 Neovim 了"
print_info "如果还有问题，请查看日志文件"
