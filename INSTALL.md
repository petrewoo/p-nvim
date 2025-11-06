# 安装指南

本指南将帮助你在不同操作系统上安装和配置 P-Nvim。

## 目录

- [系统要求](#系统要求)
- [安装 Neovim](#安装-neovim)
- [安装字体](#安装字体)
- [安装依赖工具](#安装依赖工具)
- [安装配置](#安装配置)
- [安装语言工具](#安装语言工具)
- [验证安装](#验证安装)
- [故障排除](#故障排除)

## 系统要求

- Neovim >= 0.9.0
- Git >= 2.19.0
- 支持的操作系统: macOS, Linux, Windows (WSL)

## 安装 Neovim

### macOS

使用 Homebrew:
```bash
brew install neovim
```

### Ubuntu/Debian

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

或从源码编译:
```bash
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

### Arch Linux

```bash
sudo pacman -S neovim
```

### Windows

使用 Scoop:
```powershell
scoop install neovim
```

或使用 Chocolatey:
```powershell
choco install neovim
```

## 安装字体

### 推荐字体

推荐使用 Nerd Fonts，它包含了大量的图标支持。

#### macOS

```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

#### Linux

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf
fc-cache -fv
```

#### 手动安装

1. 访问 [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
2. 下载 Hack Nerd Font (或其他你喜欢的字体)
3. 安装字体文件
4. 在终端设置中配置使用该字体

### 终端配置

#### iTerm2 (macOS)
1. 打开 iTerm2 → Preferences → Profiles → Text
2. 在 Font 中选择 "Hack Nerd Font"

#### Terminal.app (macOS)
1. 打开 Terminal → Preferences → Profiles
2. 选择 Font 并设置为 "Hack Nerd Font"

#### GNOME Terminal (Linux)
1. Edit → Preferences → Profiles
2. 选择自定义字体并设置为 "Hack Nerd Font"

## 安装依赖工具

### 基础工具

#### macOS

```bash
# Node.js (用于某些 LSP 服务器)
brew install node

# Python 3
brew install python3

# Ripgrep (用于搜索)
brew install ripgrep

# fd (用于文件查找)
brew install fd

# Lazygit (可选，Git UI)
brew install lazygit
```

#### Ubuntu/Debian

```bash
# Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Python 3
sudo apt install -y python3 python3-pip

# Ripgrep
sudo apt install -y ripgrep

# fd
sudo apt install -y fd-find

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

#### Arch Linux

```bash
sudo pacman -S nodejs npm python python-pip ripgrep fd lazygit
```

## 安装配置

### 1. 备份现有配置

如果你已经有 Neovim 配置，先备份:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. 克隆配置

```bash
git clone https://github.com/petrewoo/p-nvim.git ~/.config/nvim
```

或者如果你在本地:

```bash
cp -r /path/to/p-nvim/nvim ~/.config/
```

### 3. 首次启动

```bash
nvim
```

首次启动时，lazy.nvim 会自动安装所有插件。这可能需要几分钟时间。

### 4. 安装 LSP 服务器

在 Neovim 中运行:

```vim
:Mason
```

推荐安装的 LSP 服务器:
- `lua-language-server` - Lua
- `pyright` - Python
- `typescript-language-server` - JavaScript/TypeScript
- `rust-analyzer` - Rust
- `gopls` - Go
- `bash-language-server` - Bash
- `json-lsp` - JSON
- `yaml-language-server` - YAML

使用 `i` 键安装选中的服务器。

## 安装语言工具

### Python

```bash
# Python 包管理和格式化工具
pip3 install --user pynvim flake8 black isort
```

### JavaScript/TypeScript

```bash
# ESLint 和 Prettier
npm install -g eslint prettier
```

### Go

```bash
# Go 工具
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
```

### Rust

```bash
# Rust 工具链
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer
```

## 验证安装

### 检查 Neovim 版本

```bash
nvim --version
```

应该显示 >= 0.9.0

### 检查健康状态

在 Neovim 中运行:

```vim
:checkhealth
```

这会显示所有依赖的状态。修复任何警告或错误。

### 测试 LSP

1. 打开一个 Python 文件:
```bash
nvim test.py
```

2. 输入一些代码并测试自动补全 (Ctrl+Space)

3. 将光标放在函数上，按 `K` 查看文档

### 测试插件

- 按 `<leader>e` (`,e`) 打开文件浏览器
- 按 `<C-p>` 打开文件查找
- 按 `<leader>ff` 测试 Telescope

## 故障排除

### 插件未加载

```vim
:Lazy sync
:Lazy clean
:Lazy update
```

### LSP 不工作

1. 检查服务器是否安装:
```vim
:Mason
```

2. 查看 LSP 日志:
```vim
:LspLog
```

3. 检查 LSP 信息:
```vim
:LspInfo
```

### 图标显示为方块

确保:
1. 安装了 Nerd Font
2. 终端配置使用了 Nerd Font
3. 终端支持 Unicode

### 启动慢

查看启动时间:
```bash
nvim --startuptime startup.log
```

检查插件性能:
```vim
:Lazy profile
```

### 颜色主题不正确

确保终端支持真彩色 (truecolor):

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc
export TERM=xterm-256color
```

或者:
```bash
export COLORTERM=truecolor
```

### Python 提供者错误

```bash
pip3 install --user pynvim
```

### Node.js 提供者错误

```bash
npm install -g neovim
```

## 更新

### 更新配置

```bash
cd ~/.config/nvim
git pull
```

### 更新插件

在 Neovim 中:
```vim
:Lazy update
```

### 更新 LSP 服务器

```vim
:Mason
```

然后按 `U` 更新所有已安装的包。

## 卸载

如果你想卸载此配置:

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

然后恢复备份:
```bash
mv ~/.config/nvim.bak ~/.config/nvim
mv ~/.local/share/nvim.bak ~/.local/share/nvim
```

## 获取帮助

- 查看 [README.md](README.md) 了解快捷键和功能
- 提交 Issue 到 GitHub
- 查看 [Neovim 文档](https://neovim.io/doc/)
- 加入 Neovim 社区

## 下一步

现在你已经安装完成，可以:

1. 阅读 [README.md](README.md) 了解所有快捷键
2. 自定义配置文件以适应你的工作流
3. 探索不同的插件和主题
4. 开始享受现代化的 Neovim 体验！
