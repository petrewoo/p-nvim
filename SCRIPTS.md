# P-Nvim 脚本使用指南

本项目提供了多个实用脚本，帮助你轻松管理 Neovim 配置。

## 📋 脚本概览

| 脚本 | 用途 | 适用场景 |
|------|------|----------|
| [install.sh](#installsh) | 一键安装 | 首次安装 |
| [quick-install.sh](#quick-installsh) | 快速安装 | 已有 Neovim |
| [maintenance.sh](#maintenancesh) | 日常维护 | 定期维护 |
| [uninstall.sh](#uninstallsh) | 卸载清理 | 卸载或清理 |

---

## install.sh

### 功能
完整的一键安装脚本，自动检查和安装所有依赖。

### 适用场景
- 首次安装 P-Nvim
- 没有 Neovim 或版本过低
- 需要安装依赖工具

### 使用方法
```bash
./install.sh
```

### 安装流程
1. ✅ 检测操作系统（macOS/Linux）
2. ✅ 检查 Neovim 版本，必要时自动安装
3. ✅ 检查依赖工具（git, ripgrep, fd, node）
4. ✅ 提示安装可选工具
5. ✅ 备份现有配置
6. ✅ 安装 Nerd Font（可选）
7. ✅ 复制配置文件
8. ✅ 安装 Python 依赖
9. ✅ 首次启动，自动安装所有插件

### 特点
- **智能检测**: 自动检测已安装的工具
- **安全备份**: 自动备份现有配置
- **交互式**: 每一步都会征求确认
- **全自动**: 一次运行完成所有配置

### 适合人群
- Neovim 新手
- 需要完整安装环境的用户
- 希望自动化安装的用户

---

## quick-install.sh

### 功能
极速安装脚本，适合已有 Neovim 环境的用户。

### 适用场景
- 已安装 Neovim >= 0.9.0
- 已有基础依赖工具
- 只需要配置文件

### 使用方法
```bash
./quick-install.sh
```

### 安装流程
1. ✅ 备份现有配置
2. ✅ 复制配置文件
3. ✅ 完成！

### 特点
- **快速**: 30 秒内完成
- **简洁**: 只复制配置文件
- **安全**: 自动备份现有配置

### 适合人群
- Vim/Neovim 老手
- 已有完整开发环境
- 只想试用配置的用户

---

## maintenance.sh

### 功能
日常维护工具，提供更新、清理、优化等功能。

### 适用场景
- 定期维护配置
- 更新插件和 LSP
- 清理缓存和优化
- 备份恢复配置

### 使用方法
```bash
./maintenance.sh
```

### 功能菜单

#### 1. 更新所有插件
更新所有已安装的插件到最新版本。

**命令**:
```bash
./maintenance.sh  # 选择 1
```

**等效操作**:
```vim
:Lazy update
```

#### 2. 清理未使用的插件
删除配置中不再使用的插件。

**适用场景**:
- 删除了插件配置后
- 插件目录占用过多空间

#### 3. 更新 LSP 服务器
更新所有已安装的语言服务器。

**等效操作**:
```vim
:Mason
# 然后按 U
```

#### 4. 检查健康状态
运行 Neovim 健康检查，诊断配置问题。

**等效操作**:
```vim
:checkhealth
```

#### 5. 优化启动速度
分析启动性能，找出耗时的插件和配置。

**输出**:
- 启动耗时分析
- 优化建议

**适用场景**:
- 启动速度变慢
- 需要性能调优

#### 6. 清理缓存
清理 Neovim 缓存文件，释放磁盘空间。

**清理内容**:
- ~/.cache/nvim/*
- 日志文件
- 30 天前的撤销历史（可选）

#### 7. 备份配置
备份当前配置到 `~/nvim-backups/`。

**特点**:
- 自动添加时间戳
- 自动清理旧备份（保留最近 5 个）
- 压缩存储

#### 8. 恢复配置
从备份恢复配置。

**流程**:
1. 列出所有可用备份
2. 选择要恢复的备份
3. 备份当前配置
4. 恢复选定的备份

#### 9. 完整维护（推荐）
一次性执行所有维护任务。

**包含**:
1. 更新插件
2. 清理未使用的插件
3. 更新 LSP 服务器
4. 清理缓存
5. 备份配置

**推荐频率**: 每周或每月运行一次

### 使用建议

**日常使用**:
```bash
# 快速更新
./maintenance.sh  # 选择 1

# 定期维护（推荐）
./maintenance.sh  # 选择 9
```

**性能优化**:
```bash
./maintenance.sh  # 选择 5, 6
```

**备份管理**:
```bash
# 手动备份
./maintenance.sh  # 选择 7

# 恢复备份
./maintenance.sh  # 选择 8
```

---

## uninstall.sh

### 功能
卸载和清理工具，提供多种卸载选项。

### 使用方法
```bash
./uninstall.sh
```

### 功能菜单

#### 1. 完全卸载
删除所有 P-Nvim 相关文件。

**删除内容**:
- ~/.config/nvim
- ~/.local/share/nvim
- ~/.cache/nvim
- ~/.local/state/nvim

**适用场景**:
- 完全卸载 P-Nvim
- 重新开始

**注意**: 操作前会提示备份

#### 2. 只删除配置文件
只删除配置，保留插件和缓存。

**删除内容**:
- ~/.config/nvim

**保留内容**:
- ~/.local/share/nvim（插件）
- ~/.cache/nvim（缓存）

**适用场景**:
- 想重新安装配置
- 保留已安装的插件

#### 3. 只清理缓存和插件
删除插件和缓存，保留配置。

**删除内容**:
- ~/.local/share/nvim
- ~/.cache/nvim
- ~/.local/state/nvim

**保留内容**:
- ~/.config/nvim（配置）

**适用场景**:
- 插件出问题，需要重新安装
- 清理空间但保留配置

#### 4. 清理插件缓存
只清理插件缓存，最小程度的清理。

**删除内容**:
- lazy.nvim 插件
- Mason LSP 服务器
- 缓存文件

**保留内容**:
- 配置文件
- 其他数据

**适用场景**:
- 插件损坏
- 需要重新安装插件

#### 5. 重置为初始状态
完全清理后重新安装。

**流程**:
1. 备份现有配置（可选）
2. 删除所有文件
3. 自动运行 install.sh

**适用场景**:
- 配置出现严重问题
- 想要全新安装

#### 6. 显示当前占用空间
查看各目录占用的磁盘空间。

**显示内容**:
- 配置文件大小
- 插件数据大小
- 缓存文件大小
- 总计占用

### 使用建议

**轻度清理** (释放空间):
```bash
./uninstall.sh  # 选择 4
```

**中度清理** (重装插件):
```bash
./uninstall.sh  # 选择 3
```

**完全卸载**:
```bash
./uninstall.sh  # 选择 1
```

**检查空间**:
```bash
./uninstall.sh  # 选择 6
```

---

## 🎯 使用场景示例

### 场景 1: 首次安装

```bash
# 克隆项目
git clone https://github.com/petrewoo/p-nvim.git
cd p-nvim

# 运行安装脚本
./install.sh

# 启动 Neovim
nvim

# 安装 LSP 服务器
:Mason
```

### 场景 2: 更新环境

```bash
cd p-nvim

# 运行维护脚本
./maintenance.sh

# 选择 9 - 完整维护
```

### 场景 3: 插件出问题

```bash
# 方案 1: 清理插件缓存
./uninstall.sh
# 选择 4 - 清理插件缓存

# 重启 Neovim，会自动重新安装插件
nvim

# 方案 2: 如果问题依旧
./uninstall.sh
# 选择 3 - 清理缓存和插件
nvim
```

### 场景 4: 启动变慢

```bash
# 分析性能
./maintenance.sh
# 选择 5 - 优化启动速度

# 查看报告，根据建议优化

# 清理缓存
./maintenance.sh
# 选择 6 - 清理缓存
```

### 场景 5: 完全卸载

```bash
# 卸载 P-Nvim
./uninstall.sh
# 选择 1 - 完全卸载
# 选择 y - 备份配置

# 备份文件会保存在:
# ~/nvim-backup-YYYYMMDD_HHMMSS/
```

### 场景 6: 迁移到新电脑

```bash
# 在旧电脑上
cd p-nvim
./maintenance.sh
# 选择 7 - 备份配置

# 将 ~/nvim-backups/ 复制到新电脑

# 在新电脑上
git clone https://github.com/petrewoo/p-nvim.git
cd p-nvim
./install.sh

# 然后恢复配置
./maintenance.sh
# 选择 8 - 恢复配置
```

---

## 💡 使用技巧

### 定期维护

建议每月运行一次完整维护：
```bash
./maintenance.sh  # 选择 9
```

### 备份习惯

在大改动前备份配置：
```bash
./maintenance.sh  # 选择 7
```

### 性能监控

定期检查启动速度：
```bash
./maintenance.sh  # 选择 5
```

### 空间管理

定期检查磁盘占用：
```bash
./uninstall.sh  # 选择 6
```

---

## ⚠️ 注意事项

### 安全提示

1. **备份重要**: 删除操作前一定要备份
2. **确认操作**: 脚本会多次确认，请仔细阅读
3. **测试环境**: 大改动建议先在测试环境尝试

### 权限问题

如果脚本无法执行：
```bash
chmod +x install.sh quick-install.sh maintenance.sh uninstall.sh
```

### 操作系统

- **支持**: macOS, Linux
- **部分支持**: Windows (WSL)
- **不支持**: Windows (原生)

### 网络要求

- 安装脚本需要网络连接（下载插件、工具）
- 其他脚本可离线使用

---

## 🆘 故障排除

### 脚本无法运行

```bash
# 检查权限
ls -l *.sh

# 添加执行权限
chmod +x *.sh
```

### 安装失败

```bash
# 查看详细错误信息
./install.sh 2>&1 | tee install.log

# 检查 Neovim
nvim --version

# 手动安装依赖
brew install ripgrep fd node  # macOS
```

### 插件安装失败

```vim
# 在 Neovim 中
:Lazy
:Lazy clean
:Lazy sync
```

### 备份失败

```bash
# 检查磁盘空间
df -h

# 检查目录权限
ls -ld ~/nvim-backups
```

---

## 📚 相关文档

- [GETTING_STARTED.md](GETTING_STARTED.md) - 入门指南
- [INSTALL.md](INSTALL.md) - 详细安装说明
- [README.md](README.md) - 项目说明
- [CHANGELOG.md](CHANGELOG.md) - 更新日志

---

## 💬 反馈

如果脚本有问题或建议改进，欢迎：
- 提交 GitHub Issue
- 发送 Pull Request
- 查看现有讨论

---

**提示**: 所有脚本都是交互式的，操作前会有确认提示，请放心使用！
