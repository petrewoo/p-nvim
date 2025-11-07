#!/bin/bash

# 设置 SDK 环境 - 适用于 macOS 26 (Sequoia)
# 解决 Xcode 和 Command Line Tools SDK 版本不匹配问题

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
echo -e "${BLUE}  macOS 26 SDK 环境配置${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo

# 检查系统版本
print_info "检查系统版本..."
OS_VERSION=$(sw_vers -productVersion)
echo "  macOS 版本: $OS_VERSION"

# 检查当前配置
print_info "当前开发工具配置："
XCODE_PATH=$(xcode-select -p)
CURRENT_SDK=$(xcrun --show-sdk-path)
echo "  xcode-select: $XCODE_PATH"
echo "  当前 SDK: $CURRENT_SDK"
echo

# 检查可用的 SDK 路径
print_info "检查可用的 SDK："
echo

# Xcode SDK
if [ -d "/Applications/Xcode.app" ]; then
    XCODE_SDK_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs"
    XCODE_SDK=$(find "$XCODE_SDK_PATH" -name "MacOSX*.sdk" -type d ! -type l | head -1)
    if [ -n "$XCODE_SDK" ]; then
        print_info "Xcode SDK："
        echo "  路径: $XCODE_SDK"
        XCODE_SDK_VERSION=$(basename "$XCODE_SDK" | sed 's/MacOSX\(.*\)\.sdk/\1/')
        echo "  版本: $XCODE_SDK_VERSION"
        echo
    fi
fi

# Command Line Tools SDK
CMDLINE_SDK="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
if [ -d "$CMDLINE_SDK" ]; then
    REAL_SDK=$(readlink "$CMDLINE_SDK" 2>/dev/null || echo "$CMDLINE_SDK")
    print_info "Command Line Tools SDK："
    echo "  路径: $CMDLINE_SDK"
    echo "  实际: $REAL_SDK"
    echo
else
    print_error "Command Line Tools SDK 不存在！"
    print_info "请安装 Command Line Tools: xcode-select --install"
    exit 1
fi

# 检查当前使用的 SDK 是否匹配
if [[ "$CURRENT_SDK" == *"Xcode.app"* ]] && [[ "$XCODE_PATH" == *"CommandLineTools"* ]]; then
    print_warning "SDK 路径不匹配！"
    echo "  xcode-select 指向: Command Line Tools"
    echo "  但 xcrun 使用的是: Xcode SDK"
    echo "  这可能导致编译问题！"
    echo
elif [[ "$CURRENT_SDK" == *"CommandLineTools"* ]] && [[ "$XCODE_PATH" == *"Xcode.app"* ]]; then
    print_warning "SDK 路径不匹配！"
    echo "  xcode-select 指向: Xcode"
    echo "  但 xcrun 使用的是: Command Line Tools SDK"
    echo "  这可能导致编译问题！"
    echo
fi

# 检查是否已经配置了 SDKROOT
print_info "检查现有的 SDK 环境变量配置..."
if [ -f ~/.zshrc ]; then
    SHELL_CONFIG=~/.zshrc
elif [ -f ~/.bashrc ]; then
    SHELL_CONFIG=~/.bashrc
else
    SHELL_CONFIG=~/.profile
fi

EXISTING_SDKROOT=$(grep "^export SDKROOT=" "$SHELL_CONFIG" 2>/dev/null | head -1)
if [ -n "$EXISTING_SDKROOT" ]; then
    print_success "已找到现有的 SDKROOT 配置"
    echo "  $EXISTING_SDKROOT"
    CONFIGURED_SDK=$(echo "$EXISTING_SDKROOT" | sed 's/export SDKROOT=//' | tr -d '"' | tr -d "'")
    if [ -d "$CONFIGURED_SDK" ]; then
        print_success "配置的 SDK 路径有效"
        echo "  路径: $CONFIGURED_SDK"
    else
        print_warning "配置的 SDK 路径不存在！"
        echo "  路径: $CONFIGURED_SDK"
    fi
    echo
fi

# 提供解决方案
print_info "推荐的解决方案："
echo
if [ -n "$EXISTING_SDKROOT" ] && [ -d "$CONFIGURED_SDK" ]; then
    echo "✓ 你的 $SHELL_CONFIG 已经正确配置了 SDKROOT"
    echo "  如果仍有编译问题，请运行: ./fix-compile-headers.sh"
    echo
else
    echo "1. 【推荐】使用 Command Line Tools SDK（适合 macOS 26）:"
    echo "   • 路径: /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
    echo "   • 需要在 shell 配置中添加 SDKROOT 环境变量"
    echo
    if [ -n "$XCODE_SDK" ]; then
        echo "2. 使用 Xcode SDK（如果你已经安装了 Xcode）:"
        echo "   • 路径: $XCODE_SDK"
        echo "   • SDK 版本: $XCODE_SDK_VERSION"
        echo
    fi
fi

if [ -n "$EXISTING_SDKROOT" ] && [ -d "$CONFIGURED_SDK" ]; then
    print_success "SDK 环境变量已正确配置，无需修改"
else
    echo
    read -p "是否要添加 SDK 环境变量到你的 shell 配置? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "将添加到: $SHELL_CONFIG"

        # 确定使用哪个 SDK
        if [ -n "$XCODE_SDK" ]; then
            RECOMMENDED_SDK="$XCODE_SDK"
        else
            RECOMMENDED_SDK="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
        fi

        cat >> "$SHELL_CONFIG" << EOF

# macOS SDK 配置 (for Neovim plugins compilation)
export SDKROOT="$RECOMMENDED_SDK"
export CPATH="\$SDKROOT/usr/include"
EOF
        print_success "已添加 SDK 环境变量"
        echo "  SDKROOT=$RECOMMENDED_SDK"
        echo
        print_info "请运行以下命令使其生效:"
        echo "  source $SHELL_CONFIG"
        echo
        print_info "或者重新打开终端"
    fi
fi

echo
print_success "配置检查完成！"
echo
print_info "下一步："
if [ -n "$EXISTING_SDKROOT" ]; then
    echo "  1. SDK 已配置，直接运行: ./fix-compile-headers.sh"
    echo "  2. 启动 Neovim"
else
    echo "  1. 如果添加了新配置，运行: source $SHELL_CONFIG (或重启终端)"
    echo "  2. 运行: ./fix-compile-headers.sh"
    echo "  3. 启动 Neovim"
fi
