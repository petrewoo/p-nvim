# 更新日志

本文档记录了 P-Nvim 配置的所有重要变更。

## [1.0.0] - 2025-11-05

### 初始发布

从 [k-vim](https://github.com/petrewoo/k-vim) 迁移到现代化的 Neovim 配置。

### 新增功能

#### 核心改进
- ✨ 使用 Lua 重写整个配置
- ✨ 采用 lazy.nvim 作为插件管理器
- ✨ 模块化的配置结构
- ✨ 持久化撤销历史
- ✨ 更好的启动性能

#### 插件升级

**UI 增强**
- 新增 lualine.nvim 替代 vim-airline
- 新增 bufferline.nvim 用于缓冲区管理
- 新增 indent-blankline.nvim 显示缩进参考线
- 新增 rainbow-delimiters.nvim 彩虹括号
- 新增 neoscroll.nvim 平滑滚动

**编辑器功能**
- nvim-tree.lua 替代 NERDTree
- telescope.nvim 替代 CtrlP
- aerial.nvim 替代 Tagbar
- hop.nvim 替代 vim-easymotion
- Comment.nvim 替代 nerdcommenter
- nvim-autopairs 替代 delimitMate
- nvim-surround 替代 vim-surround
- nvim-spectre 用于高级搜索替换
- which-key.nvim 显示快捷键提示

**LSP 和补全**
- nvim-lspconfig 提供原生 LSP 支持
- mason.nvim 用于 LSP 服务器管理
- nvim-cmp 替代 YouCompleteMe
- LuaSnip 替代 UltiSnips
- nvim-lint 用于代码检查
- conform.nvim 用于代码格式化

**语法高亮**
- nvim-treesitter 提供更好的语法高亮
- treesitter-textobjects 用于文本对象操作
- treesitter-context 显示函数上下文

**Git 集成**
- gitsigns.nvim 替代 vim-gitgutter
- vim-fugitive 保持不变
- 新增 git-conflict.nvim 用于冲突解决
- 新增 diffview.nvim 用于 diff 查看

**其他功能**
- 新增 alpha-nvim 启动界面
- 新增 toggleterm.nvim 终端管理
- 新增 project.nvim 项目管理
- 新增 trouble.nvim 更好的诊断显示
- 新增 todo-comments.nvim TODO 高亮
- 新增 persistence.nvim 会话管理

### 保持的快捷键

以下快捷键与 k-vim 保持一致:

- Leader 键: `,`
- 窗口导航: `<C-h/j/k/l>`
- 快速退出插入: `kj`
- 命令模式: `;`
- 保存: `<leader>w`
- 退出: `<leader>q`
- 标签页操作: `tn/td/tj/tk`
- 缓冲区导航: `[b/]b`
- 行首/行尾: `H/L`
- Git 快捷键前缀: `<leader>g`

### 新增快捷键

- `<leader>e` - 切换文件浏览器
- `<C-p>` - 快速查找文件
- `<leader>ff` - Telescope 查找文件
- `<leader>fg` - Telescope 全局搜索
- `<leader>fb` - Telescope 查找缓冲区
- `<leader>hw` - Hop 跳转到单词
- `<leader>a` - 切换代码大纲
- `<leader>u` - 撤销树
- `<leader>xx` - 切换 Trouble
- `<C-\>` - 切换终端
- `<leader>mp` - Markdown 预览

### 配置文件结构

```
nvim/
├── init.lua              # 主入口文件
└── lua/
    ├── core.lua         # 核心配置
    ├── keymaps.lua      # 按键映射
    └── plugins/         # 插件配置目录
        ├── init.lua     # 插件入口
        ├── ui.lua       # UI 相关
        ├── editor.lua   # 编辑器增强
        ├── lsp.lua      # LSP 配置
        ├── treesitter.lua # 语法高亮
        ├── git.lua      # Git 集成
        ├── languages.lua # 语言特定
        └── misc.lua     # 其他插件
```

### 移除的插件

以下插件因为有更好的替代品或不再需要而移除:

- YouCompleteMe → nvim-lspconfig + nvim-cmp
- UltiSnips → LuaSnip
- vim-airline → lualine.nvim
- NERDTree → nvim-tree.lua
- CtrlP → telescope.nvim
- vim-easymotion → hop.nvim
- nerdcommenter → Comment.nvim
- delimitMate → nvim-autopairs
- Syntastic/ALE → nvim-lint + LSP diagnostics
- vim-indent-guides → indent-blankline.nvim
- rainbow_parentheses.vim → rainbow-delimiters.nvim

### 系统要求

- Neovim >= 0.9.0
- Git >= 2.19.0
- Node.js (用于某些 LSP)
- Python 3 + pip
- Nerd Font (用于图标显示)

### 性能改进

- 延迟加载大部分插件
- 使用 lazy.nvim 的智能加载机制
- Treesitter 按需编译
- 优化的启动时间

### 文档

- README.md - 完整功能说明和快捷键列表
- INSTALL.md - 详细安装指南
- QUICKSTART.md - 5 分钟快速入门
- CHANGELOG.md - 更新日志

### 迁移指南

如果你是从 k-vim 迁移过来:

1. **备份旧配置**: `mv ~/.vim ~/.vim.bak`
2. **安装新配置**: 按照 INSTALL.md 操作
3. **熟悉新插件**:
   - 使用 nvim-tree 而不是 NERDTree
   - 使用 Telescope 而不是 CtrlP
   - LSP 补全会自动工作
4. **调整习惯**:
   - 大部分快捷键保持不变
   - 新的 LSP 功能更强大
   - Treesitter 提供更好的语法高亮

### 已知问题

- 首次启动需要下载和安装所有插件，可能需要几分钟
- 某些 LSP 服务器需要手动通过 Mason 安装
- Windows 支持通过 WSL 测试，原生 Windows 可能有问题

### 致谢

感谢以下项目:
- [k-vim](https://github.com/petrewoo/k-vim) - 原始配置
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [NvChad](https://nvchad.com/)
- [LunarVim](https://www.lunarvim.org/)
- 所有插件作者和 Neovim 社区

---

## 版本格式说明

本项目遵循 [语义化版本](https://semver.org/lang/zh-CN/) 规范。

版本格式: MAJOR.MINOR.PATCH

- MAJOR: 不兼容的 API 修改
- MINOR: 向下兼容的功能性新增
- PATCH: 向下兼容的问题修正

## 更新类型

- ✨ 新增: 新功能
- 🐛 修复: Bug 修复
- 📝 文档: 文档更新
- ♻️ 重构: 代码重构
- ⚡ 性能: 性能优化
- 🎨 样式: 代码格式调整
- 🔧 配置: 配置文件变更
- 🗑️ 移除: 移除功能或文件
