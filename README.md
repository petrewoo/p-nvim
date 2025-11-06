# P-Nvim Configuration

现代化的 Neovim 配置，从 [k-vim](https://github.com/petrewoo/k-vim) 迁移而来。使用 Lua 编写，基于 lazy.nvim 插件管理器。

## 📖 文档导航

| 文档 | 说明 | 适合人群 |
|------|------|----------|
| **[GETTING_STARTED.md](GETTING_STARTED.md)** | 🎯 **从这里开始！** 新手入门指南 | 所有人 |
| [DEMO.md](DEMO.md) | 5分钟演示教程，跟随操作学习 | 新手 |
| [CHEATSHEET.md](CHEATSHEET.md) | 快捷键速查表，打印备查 | 所有人 |
| [QUICKSTART.md](QUICKSTART.md) | 快速入门，了解核心功能 | 有经验用户 |
| [CLAUDE_AI.md](CLAUDE_AI.md) | 🤖 Claude AI 集成指南 | AI 用户 |
| [INSTALL.md](INSTALL.md) | 详细安装指南和故障排除 | 遇到问题时 |
| [SCRIPTS.md](SCRIPTS.md) | 脚本使用指南 | 维护管理 |
| [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) | 项目结构说明 | 定制配置 |
| [CHANGELOG.md](CHANGELOG.md) | 更新日志 | 了解变更 |

**💡 建议**: 如果是第一次使用，请先阅读 **[GETTING_STARTED.md](GETTING_STARTED.md)**！
**🤖 新功能**: 已集成 Claude AI，查看 **[CLAUDE_AI.md](CLAUDE_AI.md)** 了解使用方法！

## 特性

### 核心功能
- 🚀 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 进行插件管理
- 🤖 **集成 Claude AI** - 在编辑器中直接使用 AI 助手
- 🎨 Solarized 和 Molokai 主题支持
- 📁 模块化配置结构，易于维护和定制
- ⚡ 快速启动和响应
- 💾 持久化撤销历史
- 🔍 强大的搜索和导航功能

### 插件集成

#### UI 增强
- **lualine.nvim** - 美观的状态栏
- **bufferline.nvim** - 缓冲区标签栏
- **indent-blankline.nvim** - 缩进参考线
- **rainbow-delimiters.nvim** - 彩虹括号
- **nvim-web-devicons** - 文件图标
- **neoscroll.nvim** - 平滑滚动

#### 编辑器增强
- **nvim-tree.lua** - 文件浏览器
- **telescope.nvim** - 模糊查找器
- **aerial.nvim** - 代码大纲
- **hop.nvim** - 快速跳转
- **Comment.nvim** - 智能注释
- **nvim-autopairs** - 自动括号配对
- **nvim-surround** - 环绕字符操作
- **vim-visual-multi** - 多光标编辑
- **vim-easy-align** - 快速对齐
- **undotree** - 撤销历史可视化
- **nvim-spectre** - 搜索和替换
- **which-key.nvim** - 按键绑定提示

#### LSP 和补全
- **nvim-lspconfig** - LSP 配置
- **mason.nvim** - LSP/工具安装器
- **nvim-cmp** - 自动补全引擎
- **LuaSnip** - 代码片段引擎
- **nvim-lint** - 代码检查
- **conform.nvim** - 代码格式化

#### Treesitter
- **nvim-treesitter** - 语法高亮和代码理解
- **nvim-treesitter-textobjects** - 文本对象
- **nvim-treesitter-context** - 上下文显示

#### Git 集成
- **gitsigns.nvim** - Git 状态显示
- **vim-fugitive** - Git 命令集成
- **git-conflict.nvim** - 冲突解决
- **diffview.nvim** - Diff 查看器

#### 语言支持
- Python, JavaScript/TypeScript, Go, Rust
- HTML/CSS, JSON, YAML, Markdown
- Docker, Nginx, GraphQL, Terraform
- 更多语言...

## 安装

### 🚀 一键安装（推荐）

适用于 macOS 和 Linux，会自动检查和安装所有依赖：

```bash
# 克隆仓库
git clone https://github.com/petrewoo/p-nvim.git
cd p-nvim

# 运行安装脚本
./install.sh
```

安装脚本会自动：
- ✅ 检查并安装 Neovim (>= 0.9.0)
- ✅ 检查并安装依赖工具 (git, ripgrep, fd, node)
- ✅ 备份现有配置
- ✅ 安装 Nerd Font（可选）
- ✅ 复制配置文件
- ✅ 首次启动并安装所有插件

### ⚡ 极速安装（已有 Neovim）

如果你已经安装了 Neovim >= 0.9.0：

```bash
# 克隆仓库
git clone https://github.com/petrewoo/p-nvim.git
cd p-nvim

# 快速安装
./quick-install.sh
```

### 📦 手动安装

1. 备份现有配置(如果有):
```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. 克隆此配置:
```bash
git clone https://github.com/petrewoo/p-nvim.git
cp -r p-nvim/nvim ~/.config/
```

3. 启动 Neovim（首次启动会自动安装插件）:
```bash
nvim
```

4. 安装 LSP 服务器:
```vim
:Mason
```

在 Mason 界面中选择需要的语言服务器（按 `i` 安装）。

### 前置要求

**必需**:
- Neovim >= 0.9.0
- Git >= 2.19.0

**推荐**:
- [Nerd Font](https://www.nerdfonts.com/) (推荐: Hack Nerd Font) - 用于显示图标
- ripgrep - 用于快速搜索
- fd - 用于快速查找文件
- Node.js - 用于某些 LSP 服务器
- Python 3 + pip - 用于 Python 支持

## 目录结构

```
nvim/
├── init.lua                 # 主配置文件
└── lua/
    ├── core.lua            # 核心设置
    ├── keymaps.lua         # 按键映射
    └── plugins/            # 插件配置
        ├── init.lua        # 插件入口
        ├── ui.lua          # UI 相关插件
        ├── editor.lua      # 编辑器增强
        ├── lsp.lua         # LSP 和补全
        ├── treesitter.lua  # Treesitter 配置
        ├── git.lua         # Git 集成
        ├── languages.lua   # 语言特定插件
        └── misc.lua        # 其他插件
```

## 快捷键

### Leader Key
- Leader 键: `,`

### 功能键
- `F2` - 切换行号
- `F3` - 切换可见字符
- `F4` - 切换自动换行
- `F5` - 切换粘贴模式
- `F6` - 切换语法高亮

### 窗口导航
- `<C-h/j/k/l>` - 在窗口间移动
- `<C-Up/Down/Left/Right>` - 调整窗口大小

### 快捷命令
- `;` - 命令模式 (替代 `:`)
- `<leader>w` - 保存文件
- `<leader>q` - 退出
- `<leader>/` - 清除搜索高亮

### 缓冲区和标签页
- `[b` / `]b` - 上一个/下一个缓冲区
- `<Left>` / `<Right>` - 上一个/下一个缓冲区
- `<leader>bd` - 关闭缓冲区
- `<leader>1-9` - 跳转到指定标签页
- `th/tl` - 第一个/最后一个标签页
- `tj/tk` - 下一个/上一个标签页
- `tn` - 新建标签页
- `td` - 关闭标签页

### 编辑
- `kj` / `jk` - 退出插入模式
- `H` / `L` - 行首/行尾
- `<leader>y` - 复制到系统剪贴板
- `<leader>d` - 删除不覆盖寄存器
- `gcc` - 切换当前行注释
- `gc` - 切换选中内容注释
- `ga` - 对齐

### 文件浏览和搜索
- `<leader>e` - 切换文件浏览器
- `<C-p>` / `<leader>ff` - 查找文件
- `<leader>fg` - 全局搜索
- `<leader>fb` - 查找缓冲区
- `<leader>fr` - 最近文件
- `<leader>fs` - 搜索光标下的字符串

### LSP
- `gd` - 跳转到定义
- `gD` - 跳转到声明
- `gi` - 跳转到实现
- `gr` - 查找引用
- `K` - 显示悬浮文档
- `<leader>rn` - 重命名
- `<leader>ca` - 代码操作
- `<leader>f` - 格式化代码
- `[d` / `]d` - 上一个/下一个诊断

### Git
- `<leader>gs` - Git 状态
- `<leader>gd` - Git diff
- `<leader>gc` - Git commit
- `<leader>gb` - Git blame
- `<leader>gl` - Git log
- `<leader>hp` - 预览 hunk
- `<leader>hs` - 暂存 hunk
- `<leader>hr` - 重置 hunk
- `]c` / `[c` - 下一个/上一个 hunk

### 其他
- `<leader>a` - 切换代码大纲
- `<leader>u` - 撤销树
- `<leader>xx` - 切换 Trouble
- `<C-\>` - 切换终端
- `<leader>mp` - Markdown 预览

## 自定义配置

### 修改主题

编辑 [lua/core.lua](nvim/lua/core.lua):
```lua
-- 修改这一行为你喜欢的主题
vim.cmd('colorscheme solarized')  -- 可选: molokai, gruvbox, etc.
```

### 添加新插件

在 `lua/plugins/` 目录下的相应文件中添加插件，或创建新文件。例如:

```lua
-- lua/plugins/custom.lua
return {
  {
    'author/plugin-name',
    config = function()
      -- 插件配置
    end,
  },
}
```

### 修改按键绑定

编辑 [lua/keymaps.lua](nvim/lua/keymaps.lua):
```lua
keymap('n', '<your-key>', '<command>', opts)
```

## 从 k-vim 迁移

这个配置保留了 k-vim 的大部分按键绑定和功能，主要区别：

1. **插件管理**: vim-plug → lazy.nvim
2. **配置语言**: VimScript → Lua
3. **LSP**: YouCompleteMe → nvim-lspconfig + nvim-cmp
4. **文件浏览**: NERDTree → nvim-tree.lua
5. **搜索**: CtrlP → telescope.nvim
6. **语法**: 传统 syntax → treesitter

大部分快捷键保持一致，你应该能够快速上手。

## 常见问题

### 插件安装失败

尝试:
```vim
:Lazy sync
```

### LSP 不工作

1. 确保已安装对应的语言服务器:
```vim
:Mason
```

2. 检查 LSP 状态:
```vim
:LspInfo
```

### 图标显示异常

确保安装了 Nerd Font，并在终端中正确配置。

### 性能问题

如果启动较慢，可以通过以下命令检查:
```vim
:Lazy profile
```

## 维护和管理

### 🔄 日常维护

使用维护脚本进行日常维护：
```bash
./maintenance.sh
```

维护脚本提供以下功能：
- 更新所有插件
- 清理未使用的插件
- 更新 LSP 服务器
- 健康检查
- 优化启动速度
- 清理缓存
- 备份/恢复配置
- 完整维护（推荐定期运行）

### 🧹 卸载和清理

使用卸载脚本管理配置：
```bash
./uninstall.sh
```

卸载脚本提供以下选项：
- 完全卸载（删除所有文件）
- 只删除配置（保留插件）
- 清理缓存和插件（保留配置）
- 清理插件缓存
- 重置为初始状态
- 查看磁盘占用

### 📦 手动更新

更新插件:
```vim
:Lazy update
```

更新 LSP 服务器:
```vim
:Mason
```
然后按 `U` 更新所有

更新配置（如果从 Git 安装）:
```bash
cd ~/.config/nvim
git pull
```

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT

## 致谢

- [k-vim](https://github.com/petrewoo/k-vim) - 原始 Vim 配置
- [lazy.nvim](https://github.com/folke/lazy.nvim) - 插件管理器
- [NvChad](https://nvchad.com/) - 配置参考
- [LunarVim](https://www.lunarvim.org/) - 配置参考
- 所有插件作者

## 相关资源

- [Neovim 官方文档](https://neovim.io/doc/)
- [Lua 学习指南](https://learnxinyminutes.com/docs/lua/)
- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
