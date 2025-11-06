#!/bin/bash

# P-Nvim 一键安装脚本
# 适用于 macOS 和 Linux

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

# 打印欢迎信息
print_banner() {
    cat << 'EOF'
================================================
    ____        _   __      _
   / __ \      / | / /   __(_)___ ___
  / /_/ /_____/  |/ / | / / / __ `__ \
 / ____/_____/ /|  /| |/ / / / / / / /
/_/         /_/ |_/ |___/_/_/ /_/ /_/

  现代化的 Neovim 配置 - 从 k-vim 迁移
================================================
EOF
}

# 检测操作系统
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        print_info "检测到操作系统: macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        print_info "检测到操作系统: Linux"
    else
        print_error "不支持的操作系统: $OSTYPE"
        exit 1
    fi
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 检查 Neovim 版本
check_neovim() {
    print_info "检查 Neovim..."

    if ! command_exists nvim; then
        print_warning "未检测到 Neovim"
        read -p "是否要安装 Neovim? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_neovim
        else
            print_error "Neovim 是必需的，安装已取消"
            exit 1
        fi
    else
        version=$(nvim --version | head -n1 | grep -oP 'v\K[0-9.]+' || echo "0.0.0")
        print_success "已安装 Neovim $version"

        # 检查版本是否 >= 0.9.0
        if [ "$(printf '%s\n' "0.9.0" "$version" | sort -V | head -n1)" != "0.9.0" ]; then
            print_warning "Neovim 版本过低 (需要 >= 0.9.0)"
            read -p "是否要升级 Neovim? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                install_neovim
            fi
        fi
    fi
}

# 安装 Neovim
install_neovim() {
    print_info "安装 Neovim..."

    if [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install neovim
        else
            print_error "未检测到 Homebrew，请先安装: https://brew.sh"
            exit 1
        fi
    elif [[ "$OS" == "linux" ]]; then
        if command_exists apt-get; then
            sudo apt-get update
            sudo apt-get install -y software-properties-common
            sudo add-apt-repository ppa:neovim-ppa/unstable -y
            sudo apt-get update
            sudo apt-get install -y neovim
        elif command_exists pacman; then
            sudo pacman -S neovim --noconfirm
        elif command_exists dnf; then
            sudo dnf install -y neovim
        else
            print_error "不支持的包管理器"
            exit 1
        fi
    fi

    print_success "Neovim 安装完成"
}

# 检查并安装依赖工具
check_dependencies() {
    print_info "检查依赖工具..."

    local deps_to_install=()

    # 必需工具
    if ! command_exists git; then
        deps_to_install+=("git")
    fi

    # 推荐工具
    local optional_tools=("ripgrep" "fd" "node")
    local missing_optional=()

    for tool in "${optional_tools[@]}"; do
        if ! command_exists "$tool"; then
            missing_optional+=("$tool")
        fi
    done

    # 安装必需工具
    if [ ${#deps_to_install[@]} -ne 0 ]; then
        print_warning "缺少必需工具: ${deps_to_install[*]}"
        read -p "是否要安装? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_dependencies "${deps_to_install[@]}"
        else
            print_error "必需工具未安装，安装已取消"
            exit 1
        fi
    fi

    # 提示安装可选工具
    if [ ${#missing_optional[@]} -ne 0 ]; then
        print_warning "推荐安装以下工具以获得更好的体验: ${missing_optional[*]}"
        print_info "  - ripgrep: 用于快速搜索"
        print_info "  - fd: 用于快速查找文件"
        print_info "  - node: 用于某些 LSP 服务器"
        read -p "是否要安装这些工具? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_optional_tools "${missing_optional[@]}"
        fi
    fi

    print_success "依赖检查完成"
}

# 安装依赖工具
install_dependencies() {
    print_info "安装依赖工具: $*"

    if [[ "$OS" == "macos" ]]; then
        brew install "$@"
    elif [[ "$OS" == "linux" ]]; then
        if command_exists apt-get; then
            sudo apt-get install -y "$@"
        elif command_exists pacman; then
            sudo pacman -S "$@" --noconfirm
        elif command_exists dnf; then
            sudo dnf install -y "$@"
        fi
    fi
}

# 安装可选工具
install_optional_tools() {
    local tools=("$@")

    if [[ "$OS" == "macos" ]]; then
        for tool in "${tools[@]}"; do
            case "$tool" in
                "ripgrep")
                    brew install ripgrep
                    ;;
                "fd")
                    brew install fd
                    ;;
                "node")
                    brew install node
                    ;;
            esac
        done
    elif [[ "$OS" == "linux" ]]; then
        for tool in "${tools[@]}"; do
            case "$tool" in
                "ripgrep")
                    if command_exists apt-get; then
                        sudo apt-get install -y ripgrep
                    elif command_exists pacman; then
                        sudo pacman -S ripgrep --noconfirm
                    fi
                    ;;
                "fd")
                    if command_exists apt-get; then
                        sudo apt-get install -y fd-find
                        # 创建软链接
                        sudo ln -sf $(which fdfind) /usr/local/bin/fd 2>/dev/null || true
                    elif command_exists pacman; then
                        sudo pacman -S fd --noconfirm
                    fi
                    ;;
                "node")
                    if command_exists apt-get; then
                        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
                        sudo apt-get install -y nodejs
                    elif command_exists pacman; then
                        sudo pacman -S nodejs npm --noconfirm
                    fi
                    ;;
            esac
        done
    fi
}

# 备份现有配置
backup_existing_config() {
    local nvim_config="$HOME/.config/nvim"

    if [ -d "$nvim_config" ] || [ -L "$nvim_config" ]; then
        print_warning "检测到现有的 Neovim 配置"
        local backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

        read -p "是否要备份现有配置? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "备份到: $backup_dir"
            mv "$nvim_config" "$backup_dir"
            print_success "备份完成"
        else
            print_warning "将覆盖现有配置"
            rm -rf "$nvim_config"
        fi
    fi

    # 同样备份数据目录（如果需要）
    local nvim_data="$HOME/.local/share/nvim"
    if [ -d "$nvim_data" ]; then
        print_info "检测到现有的 Neovim 数据目录"
        read -p "是否要清理旧的插件和数据? (推荐) (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            local data_backup="$HOME/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)"
            print_info "备份到: $data_backup"
            mv "$nvim_data" "$data_backup"
            print_success "数据目录备份完成"
        fi
    fi
}

# 安装配置文件
install_config() {
    print_info "安装 P-Nvim 配置..."

    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local nvim_config="$HOME/.config/nvim"

    # 创建配置目录
    mkdir -p "$HOME/.config"

    # 复制配置文件
    if [ -d "$script_dir/nvim" ]; then
        print_info "复制配置文件..."
        cp -r "$script_dir/nvim" "$nvim_config"
        print_success "配置文件安装完成"
    else
        print_error "找不到 nvim 配置目录"
        exit 1
    fi

    # 设置正确的权限
    chmod -R u+rwX "$nvim_config"
}

# 安装 Nerd Font
install_nerd_font() {
    print_info "检查 Nerd Font..."

    if [[ "$OS" == "macos" ]]; then
        if ! fc-list | grep -i "Nerd Font" >/dev/null 2>&1; then
            print_warning "未检测到 Nerd Font"
            read -p "是否要安装 Hack Nerd Font? (推荐) (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                print_info "安装 Hack Nerd Font..."
                brew tap homebrew/cask-fonts
                brew install --cask font-hack-nerd-font
                print_success "Nerd Font 安装完成"
                print_warning "请在终端设置中将字体改为 'Hack Nerd Font'"
            fi
        else
            print_success "已安装 Nerd Font"
        fi
    elif [[ "$OS" == "linux" ]]; then
        if ! fc-list | grep -i "Nerd Font" >/dev/null 2>&1; then
            print_warning "未检测到 Nerd Font"
            read -p "是否要安装 Hack Nerd Font? (推荐) (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                print_info "安装 Hack Nerd Font..."
                mkdir -p ~/.local/share/fonts
                cd ~/.local/share/fonts

                # 下载字体
                curl -fLo "Hack Bold Nerd Font Complete.ttf" \
                    https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/HackNerdFont-Bold.ttf
                curl -fLo "Hack Regular Nerd Font Complete.ttf" \
                    https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf

                # 刷新字体缓存
                fc-cache -fv

                cd - >/dev/null
                print_success "Nerd Font 安装完成"
                print_warning "请在终端设置中将字体改为 'Hack Nerd Font'"
            fi
        else
            print_success "已安装 Nerd Font"
        fi
    fi
}

# 首次启动 Neovim
first_launch() {
    print_info "准备首次启动 Neovim..."
    print_warning "首次启动将自动安装所有插件，可能需要几分钟时间"
    print_info "请耐心等待，安装完成后 Neovim 会自动退出"

    read -p "按 Enter 继续..."

    # 首次启动让 lazy.nvim 安装插件
    print_info "启动 Neovim 安装插件..."
    nvim --headless "+Lazy! sync" +qa

    print_success "插件安装完成"
}

# 安装 Python 依赖
install_python_deps() {
    print_info "检查 Python 环境..."

    if command_exists python3; then
        read -p "是否要安装 Python 依赖包? (推荐) (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "安装 Python 包..."
            python3 -m pip install --user --upgrade pynvim
            print_success "Python 依赖安装完成"
        fi
    else
        print_warning "未检测到 Python 3，某些功能可能无法使用"
    fi
}

# 打印下一步提示
print_next_steps() {
    cat << 'EOF'

================================================
✨ 安装完成！
================================================

下一步:
-------
1. 启动 Neovim:
   nvim

2. 安装 LSP 服务器 (在 Neovim 中):
   :Mason

3. 检查配置健康状态:
   :checkhealth

4. 查看快速入门指南:
   cat ~/.config/nvim/../QUICKSTART.md

常用快捷键:
-----------
Leader 键: ,
文件浏览: ,e
查找文件: Ctrl-p 或 ,ff
全局搜索: ,fg
保存文件: ,w
退出插入: kj
代码跳转: gd
查看文档: K

文档位置:
---------
完整文档: ~/.config/nvim/../README.md
快速入门: ~/.config/nvim/../QUICKSTART.md
安装指南: ~/.config/nvim/../INSTALL.md

提示:
-----
- 如果图标显示异常，请确保终端使用了 Nerd Font
- 首次使用建议先阅读 QUICKSTART.md
- 遇到问题运行 :checkhealth 诊断

================================================
祝你使用愉快！🚀
================================================

EOF
}

# 主函数
main() {
    print_banner
    echo

    # 检测操作系统
    detect_os
    echo

    # 检查 Neovim
    check_neovim
    echo

    # 检查依赖
    check_dependencies
    echo

    # 备份现有配置
    backup_existing_config
    echo

    # 安装配置
    install_config
    echo

    # 安装字体
    install_nerd_font
    echo

    # 安装 Python 依赖
    install_python_deps
    echo

    # 首次启动
    first_launch
    echo

    # 打印下一步提示
    print_next_steps
}

# 运行主函数
main "$@"
