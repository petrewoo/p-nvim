# 开始使用 P-Nvim

欢迎使用 P-Nvim！这是你的一站式入门指南。

## 🎯 30 秒快速开始

```bash
# 克隆并安装
git clone https://github.com/petrewoo/p-nvim.git
cd p-nvim
./install.sh

# 启动
nvim
```

就这么简单！安装脚本会处理一切。

## 📋 安装后清单

启动 Neovim 后，完成以下步骤：

- [ ] **1. 等待插件安装完成**（首次启动自动进行）
- [ ] **2. 安装 LSP 服务器**
  ```vim
  :Mason
  ```
  按 `i` 安装你需要的语言服务器（如 pyright, tsserver 等）

- [ ] **3. 检查健康状态**
  ```vim
  :checkhealth
  ```
  修复任何警告或错误

- [ ] **4. 测试基本功能**
  - 按 `,e` 打开文件浏览器
  - 按 `Ctrl-p` 测试文件搜索
  - 创建一个测试文件并尝试代码补全

## 📚 学习路径

### 第 1 天：基础操作（30 分钟）

**阅读材料**：
- [DEMO.md](DEMO.md) - 跟随演示操作一遍

**练习目标**：
- ✅ 能够打开/关闭文件浏览器
- ✅ 能够查找和打开文件
- ✅ 能够保存和退出
- ✅ 能够基本编辑和导航

**快捷键清单**：
```
,e       - 文件浏览器
Ctrl-p   - 查找文件
,w       - 保存
kj       - 退出插入模式
,q       - 退出
```

### 第 2 天：编辑功能（30 分钟）

**阅读材料**：
- [CHEATSHEET.md](CHEATSHEET.md) - 编辑部分

**练习目标**：
- ✅ 掌握复制粘贴
- ✅ 学会注释代码
- ✅ 使用可视模式
- ✅ 掌握撤销/重做

**快捷键清单**：
```
gcc      - 注释行
yy       - 复制行
p        - 粘贴
v        - 可视模式
u        - 撤销
```

### 第 3 天：LSP 功能（45 分钟）

**阅读材料**：
- [QUICKSTART.md](QUICKSTART.md) - LSP 部分

**练习目标**：
- ✅ 安装语言服务器
- ✅ 使用代码补全
- ✅ 跳转到定义
- ✅ 查看文档

**快捷键清单**：
```
gd       - 跳转定义
K        - 查看文档
,rn      - 重命名
,f       - 格式化
```

### 第 4 天：搜索和导航（30 分钟）

**阅读材料**：
- [DEMO.md](DEMO.md) - 搜索部分

**练习目标**：
- ✅ 文件搜索
- ✅ 全局搜索
- ✅ 缓冲区管理
- ✅ 快速跳转

**快捷键清单**：
```
,fg      - 全局搜索
,fb      - 查找缓冲区
]b/[b    - 切换缓冲区
,hw      - 快速跳转
```

### 第 5 天：Git 集成（30 分钟）

**阅读材料**：
- [README.md](README.md) - Git 部分

**练习目标**：
- ✅ 查看改动
- ✅ 暂存/撤销
- ✅ 提交代码
- ✅ 查看历史

**快捷键清单**：
```
,gs      - Git status
]c/[c    - 跳转改动
,hp      - 预览改动
,hs      - 暂存改动
```

### 第 1 周后：进阶使用

**阅读材料**：
- [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - 了解配置结构
- 插件文档 - 深入学习感兴趣的插件

**练习目标**：
- ✅ 自定义配置
- ✅ 添加新插件
- ✅ 修改快捷键
- ✅ 优化工作流

## 🗺️ 文档导航

根据你的需求选择合适的文档：

| 文档 | 适合 | 时长 |
|------|------|------|
| [DEMO.md](DEMO.md) | 从零开始学习 | 5 分钟 |
| [CHEATSHEET.md](CHEATSHEET.md) | 快速查阅 | 随时 |
| [QUICKSTART.md](QUICKSTART.md) | 快速上手 | 5 分钟 |
| [README.md](README.md) | 完整了解 | 15 分钟 |
| [INSTALL.md](INSTALL.md) | 安装问题 | 需要时 |
| [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) | 深入定制 | 30 分钟 |

## 🎯 核心概念

### Leader 键

Leader 键是 `,`（逗号）。很多快捷键都以 Leader 键开头。

例如：`,e` 表示先按 `,`，再按 `e`。

### 模式

Vim/Neovim 有不同的模式：

- **普通模式**（Normal）：默认模式，用于导航和命令
- **插入模式**（Insert）：用于输入文本，按 `i` 进入，`kj` 退出
- **可视模式**（Visual）：用于选择文本，按 `v` 进入
- **命令模式**（Command）：用于执行命令，按 `:` 进入

### 插件管理

- 使用 `lazy.nvim` 管理插件
- 命令：`:Lazy` 打开插件管理器
- 更新：`:Lazy update`
- 安装/删除插件：编辑配置文件后运行 `:Lazy sync`

### LSP（语言服务器协议）

- LSP 提供智能补全、跳转、诊断等功能
- 使用 `Mason` 管理 LSP 服务器
- 命令：`:Mason` 打开管理器
- 每种语言需要安装对应的 LSP 服务器

## 💡 使用技巧

### 1. 使用 Which-Key

按 Leader 键（`,`）后停留 1 秒，会自动显示可用的快捷键提示。

### 2. 善用补全

在插入模式下：
- 自动补全会自动弹出
- 按 `Tab` 选择下一个
- 按 `Enter` 确认

### 3. 快速导航

使用 Telescope（`Ctrl-p`）和 nvim-tree（`,e`）快速导航文件。

### 4. 多窗口工作

- `:vsplit` 垂直分屏
- `Ctrl-h/j/k/l` 在窗口间移动
- 适合同时查看多个文件

### 5. 使用 LSP

将光标放在代码上：
- 按 `K` 查看文档
- 按 `gd` 跳转到定义
- 按 `,rn` 重命名

## ❓ 常见问题

### Q: 如何退出 Neovim？

A: 按 `Esc` 确保在普通模式，然后输入 `:q` 回车。

### Q: 图标显示为方块？

A: 需要安装 Nerd Font 并在终端中配置使用。运行 `./install.sh` 时选择安装字体。

### Q: 补全不工作？

A: 
1. 检查 LSP 服务器是否安装：`:Mason`
2. 检查 LSP 状态：`:LspInfo`
3. 重启 Neovim

### Q: 如何更新插件？

A: 在 Neovim 中运行 `:Lazy update`

### Q: 如何添加新插件？

A: 
1. 编辑 `~/.config/nvim/lua/plugins/` 下的文件
2. 添加插件配置
3. 运行 `:Lazy sync`

### Q: 快捷键太多记不住？

A: 
1. 先记住最常用的 5-10 个
2. 其他的查阅 [CHEATSHEET.md](CHEATSHEET.md)
3. 按 Leader 键等一会会显示提示

## 🆘 获取帮助

### 内置帮助

```vim
:help               " 打开帮助
:help telescope     " 查看 Telescope 帮助
:help lsp           " 查看 LSP 帮助
```

### 诊断工具

```vim
:checkhealth        " 检查配置
:LspInfo            " LSP 信息
:Lazy               " 插件状态
:Mason              " LSP 服务器状态
```

### 在线资源

- [Neovim 官方文档](https://neovim.io/doc/)
- [GitHub Issues](https://github.com/petrewoo/p-nvim/issues)
- 各插件的 GitHub 页面

## 🎓 进阶学习

准备好深入了解？

1. **学习 Vim 基础**
   ```bash
   vimtutor
   ```

2. **了解 Lua**
   - 配置文件都是用 Lua 写的
   - [Learn Lua in Y Minutes](https://learnxinyminutes.com/docs/lua/)

3. **探索插件**
   - 每个插件都有详细文档
   - 查看 `~/.config/nvim/lua/plugins/` 中的配置

4. **自定义配置**
   - 修改 `~/.config/nvim/lua/core.lua` - 核心设置
   - 修改 `~/.config/nvim/lua/keymaps.lua` - 快捷键
   - 添加插件到 `~/.config/nvim/lua/plugins/`

## 🚀 下一步

现在你已经准备好了！

1. **如果你是新手**：
   - 从 [DEMO.md](DEMO.md) 开始
   - 跟随演示操作一遍
   - 打印 [CHEATSHEET.md](CHEATSHEET.md) 放在桌面

2. **如果你熟悉 Vim**：
   - 查看 [QUICKSTART.md](QUICKSTART.md)
   - 了解新功能和快捷键
   - 开始使用！

3. **如果你从 k-vim 迁移**：
   - 大部分快捷键保持一致
   - LSP 替代了 YouCompleteMe
   - Telescope 替代了 CtrlP
   - nvim-tree 替代了 NERDTree

---

## 💬 反馈

遇到问题或有建议？

- 查看 [INSTALL.md](INSTALL.md) 故障排除
- 提交 [GitHub Issue](https://github.com/petrewoo/p-nvim/issues)
- 贡献代码：Pull Request 欢迎！

---

**祝你使用愉快！🎉**

记住：不要试图一次学会所有东西。先掌握基础，然后逐步探索高级功能。Vim/Neovim 的学习是一个渐进的过程。

Happy Coding! 🚀
