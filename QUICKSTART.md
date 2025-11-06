# P-Nvim 快速入门

欢迎使用 P-Nvim！这是一份快速入门指南，帮助你在 5 分钟内开始使用。

## 🚀 快速安装

```bash
# 1. 备份旧配置
mv ~/.config/nvim ~/.config/nvim.bak

# 2. 克隆配置
git clone <your-repo> ~/.config/nvim

# 3. 启动 Neovim（会自动安装插件）
nvim
```

## 🎯 必知快捷键

### 最常用 (前 10 个)

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `,e` | 文件浏览器 | 打开/关闭 nvim-tree |
| `Ctrl-p` | 查找文件 | Telescope 文件搜索 |
| `,ff` | 查找文件 | 同上 |
| `,fg` | 全局搜索 | 在所有文件中搜索文本 |
| `gcc` | 注释行 | 切换当前行注释 |
| `,w` | 保存 | 保存当前文件 |
| `,q` | 退出 | 退出当前窗口 |
| `kj` | 退出插入 | 从插入模式返回普通模式 |
| `gd` | 跳转定义 | LSP 跳转到定义 |
| `K` | 查看文档 | LSP 显示函数文档 |

### 文件操作

```
,e          - 打开/关闭文件树
Ctrl-p      - 模糊查找文件
,ff         - 查找文件（Telescope）
,fg         - 全局搜索文本
,fb         - 查找打开的缓冲区
,fr         - 最近打开的文件
```

### 编辑增强

```
gcc         - 注释/取消注释当前行
gc          - 注释选中内容（可视模式）
kj 或 jk    - 快速退出插入模式
,y          - 复制到系统剪贴板
ga          - 对齐（可视模式）
```

### 代码导航

```
gd          - 跳转到定义
gD          - 跳转到声明
gr          - 查看所有引用
gi          - 跳转到实现
K           - 查看悬浮文档
,rn         - 重命名符号
,ca         - 代码操作
```

### 窗口管理

```
Ctrl-h/j/k/l  - 在窗口间移动
Ctrl-方向键    - 调整窗口大小
,w            - 保存文件
,q            - 退出窗口
```

### Git 操作

```
,gs         - Git status
,gd         - Git diff
,gb         - Git blame
,hp         - 预览 hunk
]c          - 下一个改动
[c          - 上一个改动
```

## 📝 基本工作流程

### 1. 打开项目

```bash
cd your-project
nvim
```

### 2. 浏览文件

- 按 `,e` 打开文件树
- 使用 `j/k` 上下移动
- 按 `Enter` 打开文件
- 按 `a` 新建文件
- 按 `d` 删除文件
- 按 `r` 重命名文件

### 3. 快速查找

- 按 `Ctrl-p` 或 `,ff` 打开文件查找
- 输入文件名进行模糊搜索
- 使用 `Ctrl-j/k` 在结果中移动
- 按 `Enter` 打开文件

### 4. 搜索内容

- 按 `,fg` 打开全局搜索
- 输入要搜索的文本
- 在结果中浏览并打开文件

### 5. 编辑代码

- 正常编辑代码
- 输入时会自动显示补全菜单
- 使用 `Tab` 选择补全项
- 按 `Enter` 确认

### 6. 使用 LSP

当你打开代码文件时:

- 将光标放在函数上，按 `K` 查看文档
- 按 `gd` 跳转到函数定义
- 按 `gr` 查看所有引用位置
- 按 `,rn` 重命名变量
- 按 `,f` 格式化代码

### 7. Git 操作

- 按 `,gs` 查看 Git 状态
- 左侧会显示改动标记（绿色+，红色-）
- 按 `,hp` 预览改动
- 按 `,hs` 暂存改动

## 🔧 首次配置

### 1. 安装 LSP 服务器

打开 Neovim，运行:
```vim
:Mason
```

推荐安装:
- `lua-language-server` (Lua)
- `pyright` (Python)
- `typescript-language-server` (JS/TS)
- 其他你使用的语言

在 Mason 界面中:
- 使用 `/` 搜索
- 按 `i` 安装
- 按 `X` 卸载
- 按 `U` 更新

### 2. 检查健康状态

```vim
:checkhealth
```

修复显示的任何警告或错误。

### 3. 安装依赖工具

```bash
# macOS
brew install ripgrep fd node python3

# Ubuntu
sudo apt install ripgrep fd-find nodejs python3 python3-pip
```

## 💡 实用技巧

### 多光标编辑

1. 选择一个词（可视模式）
2. 按 `Ctrl-n` 选择下一个相同的词
3. 继续按 `Ctrl-n` 选择更多
4. 开始编辑，所有光标同时修改

### 快速跳转

1. 按 `,hw` 激活 Hop
2. 输入目标词的开头字母
3. 输入显示的提示字符快速跳转

### 代码片段

输入触发词，如 `for`，然后:
- 自动显示片段建议
- 按 `Tab` 确认并跳转到下一个占位符

### 分屏操作

```
:vsplit     - 垂直分屏
:split      - 水平分屏
Ctrl-h/j/k/l - 在分屏间移动
Ctrl-w c    - 关闭当前分屏
```

### 标签页

```
,1 到 ,9    - 跳转到第 1-9 个标签页
tn          - 新建标签页
td          - 关闭标签页
tj/tk       - 下一个/上一个标签页
```

## 🎨 自定义

### 修改主题

编辑 `~/.config/nvim/lua/core.lua`:

```lua
-- 找到这一行并修改为你喜欢的主题
vim.cmd('colorscheme solarized')  -- 或 molokai
```

### 修改 Leader 键

编辑 `~/.config/nvim/lua/core.lua`:

```lua
-- 修改这一行
vim.g.mapleader = ','  -- 改成你想要的键，如 ' '（空格）
```

### 添加快捷键

编辑 `~/.config/nvim/lua/keymaps.lua`:

```lua
-- 添加你的快捷键
keymap('n', '<leader>h', ':echo "Hello"<CR>', opts)
```

## 🆘 常见问题

### Q: 如何退出 Neovim？
A: 按 `Esc` 确保在普通模式，然后输入 `:q` 回车。或使用 `,q`。

### Q: 补全不工作？
A:
1. 检查 LSP 是否安装: `:Mason`
2. 检查 LSP 状态: `:LspInfo`
3. 重启 Neovim

### Q: 图标显示异常？
A: 确保安装了 Nerd Font 并在终端中配置使用。

### Q: 如何更新插件？
A: 在 Neovim 中运行 `:Lazy update`

### Q: 启动很慢？
A: 运行 `:Lazy profile` 查看哪个插件导致的。

## 📚 学习资源

### 内置帮助

```vim
:help                  - 打开帮助文档
:help telescope        - 查看 Telescope 帮助
:help lsp              - 查看 LSP 帮助
```

### 推荐学习路径

1. **第 1 天**: 熟悉基本导航和文件操作
2. **第 2 天**: 学习编辑和补全功能
3. **第 3 天**: 掌握 LSP 和代码导航
4. **第 4 天**: 学习 Git 集成
5. **第 1 周后**: 开始自定义配置

### Vim 基础

如果你不熟悉 Vim，运行:
```bash
vimtutor
```

这是一个 30 分钟的交互式教程，教你 Vim 基础。

## 🚀 进阶使用

准备好了？查看:

- [README.md](README.md) - 完整功能列表和快捷键
- [INSTALL.md](INSTALL.md) - 详细安装指南
- `~/.config/nvim/lua/plugins/` - 插件配置文件

## 💬 获取帮助

- GitHub Issues: 报告 bug 或请求功能
- 查看插件文档: 大多数问题可以在插件的 GitHub 页面找到答案

---

现在开始享受你的现代化 Neovim 配置吧！🎉

提示: 不要尝试一次学会所有东西。先掌握基础操作，然后逐步学习高级功能。
