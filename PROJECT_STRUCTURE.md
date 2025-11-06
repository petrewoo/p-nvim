# P-Nvim 项目结构

本文档说明了整个项目的文件组织和结构。

## 目录树

```
p-nvim/
├── .gitignore                  # Git 忽略文件配置
├── README.md                   # 项目主文档
├── INSTALL.md                  # 详细安装指南
├── QUICKSTART.md              # 快速入门指南
├── CHANGELOG.md               # 更新日志
├── PROJECT_STRUCTURE.md       # 本文件
└── nvim/                      # Neovim 配置目录
    ├── init.lua               # 主配置入口
    └── lua/                   # Lua 配置文件目录
        ├── core.lua           # 核心编辑器设置
        ├── keymaps.lua        # 快捷键映射
        └── plugins/           # 插件配置目录
            ├── init.lua       # 插件配置入口
            ├── ui.lua         # UI 和外观插件
            ├── editor.lua     # 编辑器增强插件
            ├── lsp.lua        # LSP 和补全配置
            ├── treesitter.lua # Treesitter 配置
            ├── git.lua        # Git 集成插件
            ├── languages.lua  # 语言特定插件
            └── misc.lua       # 其他杂项插件
```

## 核心文件说明

### 根目录文件

#### README.md
- **用途**: 项目主要文档
- **内容**:
  - 功能特性介绍
  - 快捷键完整列表
  - 插件说明
  - 基础使用说明
  - 自定义配置指南
  - 从 k-vim 迁移说明

#### INSTALL.md
- **用途**: 详细安装指南
- **内容**:
  - 系统要求
  - 各操作系统安装步骤
  - 字体安装
  - 依赖工具安装
  - LSP 服务器安装
  - 验证和故障排除

#### QUICKSTART.md
- **用途**: 快速入门指南
- **内容**:
  - 5 分钟快速安装
  - 前 10 个最常用快捷键
  - 基本工作流程
  - 实用技巧
  - 常见问题快速解答

#### CHANGELOG.md
- **用途**: 版本更新记录
- **内容**:
  - 版本历史
  - 新增功能
  - Bug 修复
  - 重要变更
  - 迁移指南

#### .gitignore
- **用途**: Git 版本控制忽略配置
- **内容**:
  - 插件安装目录
  - 缓存文件
  - 临时文件
  - 系统文件

### Neovim 配置文件

#### nvim/init.lua
- **用途**: Neovim 配置入口文件
- **内容**:
  - lazy.nvim 引导代码
  - 加载核心配置模块
  - 加载快捷键配置
  - 初始化插件系统

**文件结构**:
```lua
-- lazy.nvim 自动安装
-- 加载 core 模块
-- 加载 keymaps 模块
-- 初始化 lazy.nvim
```

#### lua/core.lua
- **用途**: 核心编辑器设置
- **内容**:
  - Leader 键设置
  - 编辑器基本选项
  - 显示设置
  - 搜索设置
  - 缩进和制表符
  - 文件编码
  - 补全设置
  - 主题配置
  - 自动命令

**主要配置项**:
- Leader key: `,`
- 行号、光标行/列
- 搜索高亮和智能大小写
- 4 空格缩进
- UTF-8 编码
- 持久化撤销
- 自动重载文件
- 保存时删除尾随空格

#### lua/keymaps.lua
- **用途**: 所有快捷键映射
- **内容**:
  - 功能键映射 (F2-F6)
  - 窗口导航和调整
  - 快捷命令
  - 缓冲区操作
  - 标签页操作
  - 编辑快捷键
  - 可视模式快捷键

**快捷键分类**:
- 功能键: 切换各种选项
- 导航: 窗口、缓冲区、标签页
- 编辑: 复制、粘贴、删除
- 可视: 缩进、移动行
- 其他: 相对行号、搜索

### 插件配置文件

#### plugins/init.lua
- **用途**: 插件配置入口
- **内容**: 导入所有插件配置模块
- **作用**: lazy.nvim 会自动加载此文件

#### plugins/ui.lua
- **用途**: UI 和外观相关插件
- **包含插件**:
  - vim-colors-solarized: Solarized 主题
  - molokai: Molokai 主题
  - lualine.nvim: 状态栏
  - bufferline.nvim: 缓冲区标签
  - indent-blankline.nvim: 缩进线
  - rainbow-delimiters.nvim: 彩虹括号
  - nvim-web-devicons: 图标
  - nvim-colorizer.lua: 颜色显示
  - neoscroll.nvim: 平滑滚动

#### plugins/editor.lua
- **用途**: 编辑器功能增强
- **包含插件**:
  - nvim-tree.lua: 文件浏览器
  - telescope.nvim: 模糊查找
  - aerial.nvim: 代码大纲
  - nvim-bqf: 增强 quickfix
  - quick-scope: f/F/t/T 增强
  - hop.nvim: 快速跳转
  - Comment.nvim: 智能注释
  - nvim-autopairs: 自动括号
  - nvim-surround: 环绕操作
  - vim-visual-multi: 多光标
  - vim-easy-align: 对齐
  - vim-expand-region: 区域扩展
  - vim-signature: 标记显示
  - undotree: 撤销树
  - nvim-spectre: 搜索替换
  - which-key.nvim: 快捷键提示

#### plugins/lsp.lua
- **用途**: LSP 和代码补全
- **包含插件**:
  - nvim-lspconfig: LSP 客户端配置
  - mason.nvim: LSP 服务器管理
  - mason-lspconfig.nvim: Mason 和 LSP 桥接
  - nvim-cmp: 补全引擎
  - cmp-nvim-lsp: LSP 补全源
  - cmp-buffer: 缓冲区补全源
  - cmp-path: 路径补全源
  - cmp-cmdline: 命令行补全
  - LuaSnip: 片段引擎
  - friendly-snippets: 片段集合
  - nvim-lint: 代码检查
  - conform.nvim: 代码格式化

**LSP 配置**:
- 预配置的语言服务器
- 统一的快捷键绑定
- 诊断配置和图标
- 自动格式化

#### plugins/treesitter.lua
- **用途**: Treesitter 语法高亮
- **包含插件**:
  - nvim-treesitter: 核心
  - nvim-treesitter-textobjects: 文本对象
  - nvim-treesitter-context: 上下文显示

**功能**:
- 增强的语法高亮
- 智能缩进
- 增量选择
- 文本对象操作

#### plugins/git.lua
- **用途**: Git 集成
- **包含插件**:
  - gitsigns.nvim: Git 状态显示
  - vim-fugitive: Git 命令
  - git-conflict.nvim: 冲突解决
  - diffview.nvim: Diff 查看

**功能**:
- 行内 Git 状态
- Git 命令集成
- Hunk 操作
- 冲突标记和解决

#### plugins/languages.lua
- **用途**: 语言特定插件
- **支持语言**:
  - Python: python-syntax
  - Markdown: vim-markdown, markdown-preview
  - Go: vim-go
  - Rust: rust.vim
  - JavaScript/TypeScript: vim-javascript, vim-jsx-pretty
  - HTML/CSS: emmet-vim
  - JSON: vim-json
  - YAML: vim-yaml
  - TOML: vim-toml
  - Docker: Dockerfile.vim
  - Nginx: nginx.vim
  - GraphQL: vim-graphql
  - Terraform: vim-terraform

#### plugins/misc.lua
- **用途**: 其他杂项插件
- **包含插件**:
  - vim-tmux-navigator: Tmux 集成
  - persistence.nvim: 会话管理
  - alpha-nvim: 启动界面
  - toggleterm.nvim: 终端管理
  - project.nvim: 项目管理
  - trouble.nvim: 诊断列表
  - todo-comments.nvim: TODO 高亮
  - fm-nvim: 文件运行
  - vim-repeat: 重复插件命令
  - vim-polyglot: 多语言语法

## 运行时生成的文件/目录

这些文件/目录会在 Neovim 运行时自动生成，已在 .gitignore 中忽略:

```
nvim/
├── lazy-lock.json           # lazy.nvim 插件锁定文件
├── plugin/                  # lazy.nvim 自动生成
├── undo/                    # 持久化撤销文件
└── sessions/                # 会话文件
```

## Neovim 数据目录

Neovim 还会在以下位置存储数据:

### macOS/Linux
```
~/.local/share/nvim/         # 数据目录
├── lazy/                    # 插件安装目录
├── mason/                   # LSP 服务器安装目录
└── site/                    # 站点相关文件

~/.cache/nvim/               # 缓存目录
└── ...

~/.local/state/nvim/         # 状态文件
└── ...
```

### Windows
```
%LOCALAPPDATA%\nvim\         # 配置目录
%LOCALAPPDATA%\nvim-data\    # 数据目录
```

## 配置加载顺序

1. `init.lua` 被加载
2. lazy.nvim 被引导和初始化
3. 加载 `lua/core.lua` (核心设置)
4. 加载 `lua/keymaps.lua` (快捷键)
5. lazy.nvim 加载 `lua/plugins/init.lua`
6. 所有插件配置被导入和处理
7. 插件按需加载或延迟加载

## 模块依赖关系

```
init.lua
  ├── lazy.nvim (引导)
  ├── core.lua (无依赖)
  ├── keymaps.lua (无依赖)
  └── plugins/init.lua
        ├── ui.lua
        ├── editor.lua
        ├── lsp.lua
        │     └── mason.nvim (必需)
        ├── treesitter.lua
        ├── git.lua
        ├── languages.lua
        └── misc.lua
```

## 自定义配置位置

建议的自定义配置位置:

1. **修改核心设置**: `lua/core.lua`
2. **添加/修改快捷键**: `lua/keymaps.lua`
3. **添加新插件**: 在 `lua/plugins/` 下创建新文件或修改现有文件
4. **语言特定配置**: `lua/plugins/languages.lua`
5. **LSP 配置**: `lua/plugins/lsp.lua`

## 文件命名规范

- 所有 Lua 文件使用小写加下划线: `file_name.lua`
- 文档文件使用大写: `README.md`, `INSTALL.md`
- 配置文件按功能分组
- 插件配置按类别组织

## 最佳实践

1. **保持模块化**: 每个文件只负责一个功能领域
2. **注释清晰**: 为复杂配置添加注释
3. **使用延迟加载**: 在插件配置中指定 `lazy = true` 或事件触发
4. **避免重复**: 使用函数和变量提取重复代码
5. **性能优先**: 只启用需要的功能
6. **文档同步**: 修改配置后更新相关文档

## 相关链接

- [Neovim 文档](https://neovim.io/doc/)
- [lazy.nvim 文档](https://github.com/folke/lazy.nvim)
- [Lua 参考](https://www.lua.org/manual/5.1/)
