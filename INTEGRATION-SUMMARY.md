# SDK 配置集成到安装/卸载脚本 - 总结

## 概述

成功将 macOS SDK 配置功能集成到 `install.sh` 和 `uninstall.sh` 中，实现了：

✅ **一键安装** - 自动配置 SDK 并编译所有插件
✅ **一键卸载** - 完全清理包括 SDK 配置在内的所有 P-Nvim 相关设置
✅ **智能检测** - 自动识别现有 SDK 配置，避免重复或冲突
✅ **安全清理** - 只清理 P-Nvim 添加的配置，保留用户原有设置

---

## 修改的文件

### 1. [install.sh](install.sh)

#### 新增功能：`setup_macos_sdk()`

- **位置**：第 352-439 行
- **调用时机**：安装字体后、首次启动 Neovim 前（第 572-574 行）

#### 主要逻辑：

1. **检测现有配置**
   ```bash
   # 检查 ~/.zshrc 中是否已有 export SDKROOT=
   # 如果存在且路径有效，使用现有配置
   # 如果缺少 CPATH，自动添加（带 P-Nvim 标记）
   ```

2. **智能 SDK 选择**
   ```bash
   # 优先级：
   # 1. Xcode SDK: /Applications/Xcode.app/.../MacOSX.sdk
   # 2. Command Line Tools SDK: /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
   ```

3. **添加配置到 Shell**
   ```bash
   # 带明确标记的配置块：
   # P-Nvim: macOS SDK 配置 (for Neovim plugins compilation)
   # AUTO-GENERATED - DO NOT EDIT MANUALLY
   export SDKROOT="..."
   export CPATH="$SDKROOT/usr/include"
   # END P-Nvim SDK Config
   ```

4. **设置当前会话环境变量**
   ```bash
   export SDKROOT="..."
   export CPATH="..."
   ```

#### 修改的函数：`first_launch()`

- **位置**：第 441-472 行
- **变更**：
  - 检测当前会话是否有 SDKROOT 环境变量
  - 如果有，编译时使用完整的 SDK 环境变量
  - 编译失败时提示可以运行 `./fix-compile-headers.sh`

```bash
# macOS 上使用 SDK 环境变量编译
SDKROOT="$SDKROOT" \
CPATH="$CPATH" \
CPPFLAGS="-isysroot $SDKROOT" \
LDFLAGS="-L$SDKROOT/usr/lib" \
nvim --headless "+Lazy! sync" +qa
```

---

### 2. [uninstall.sh](uninstall.sh)

#### 新增功能：`clean_sdk_config()`

- **位置**：第 108-145 行
- **调用时机**：
  1. 完全卸载时自动调用（第 184-185 行）
  2. 菜单选项 6：独立调用

#### 主要逻辑：

1. **检测所有 Shell 配置文件**
   ```bash
   # 检查：~/.zshrc, ~/.bashrc, ~/.profile
   ```

2. **识别 P-Nvim 添加的配置**
   ```bash
   # 通过注释标记识别：
   # "# P-Nvim.*SDK"
   # "# P-Nvim: for Neovim plugins compilation"
   ```

3. **安全删除配置块**
   ```bash
   # 删除整个配置块（从 "# P-Nvim.*SDK" 到 "# END P-Nvim SDK Config"）
   # 删除单行 CPATH 注释
   ```

4. **交互式确认**
   - 发现配置时询问是否移除
   - 支持多个配置文件的分别处理

#### 修改的函数：`full_uninstall()`

- **位置**：第 147-188 行
- **变更**：
  - 删除所有目录后调用 `clean_sdk_config()`
  - 提供完整的卸载体验

#### 修改的菜单：`show_menu()` 和 `main()`

- **新增选项 6**：清理 Shell SDK 配置
- **更新选项 7**：显示当前占用空间（原选项 6）
- **更新提示**：`[0-7]`（原 `[0-6]`）

---

## 使用场景

### 场景 1：全新安装 P-Nvim

```bash
$ ./install.sh

# 流程：
# 1. 检测操作系统、Neovim、依赖
# 2. 备份现有配置（如果有）
# 3. 安装 P-Nvim 配置文件
# 4. 安装 Nerd Font
# 5. 检查 macOS SDK 配置 ← 新增
#    - 检测可用 SDK
#    - 询问是否添加到 shell 配置
#    - 为当前会话设置环境变量
# 6. 安装 Python 依赖
# 7. 首次启动 Neovim 安装插件
#    - 使用 SDK 环境变量编译 C/C++ 插件 ← 改进
# 8. 显示下一步提示
```

**结果**：
- ✅ SDK 配置已添加到 ~/.zshrc
- ✅ 所有插件成功编译
- ✅ Neovim 可以正常使用

---

### 场景 2：重新安装（已有 SDK 配置）

```bash
$ ./install.sh

# 你的系统已经有：
# export SDKROOT=/Applications/Xcode.app/.../MacOSX26.0.sdk
# export MACOSX_DEPLOYMENT_TARGET=26.0

# 流程：
# ... (前面步骤相同)
# 5. 检查 macOS SDK 配置
#    - ✓ 检测到现有 SDKROOT 配置
#    - ✓ 验证路径有效
#    - ✓ 自动添加 CPATH（如果缺失）
#    - ✓ 设置当前会话环境变量
# 6-8. (继续正常流程)
```

**结果**：
- ✅ 保留原有 SDKROOT 配置
- ✅ 添加了 CPATH（带 P-Nvim 标记）
- ✅ 插件正常编译

---

### 场景 3：完全卸载 P-Nvim

```bash
$ ./uninstall.sh

# 选择: 1) 完全卸载

# 流程：
# 1. 询问是否备份配置
# 2. 确认删除操作
# 3. 删除所有目录：
#    - ~/.config/nvim
#    - ~/.local/share/nvim
#    - ~/.cache/nvim
#    - ~/.local/state/nvim
# 4. 清理 SDK 配置 ← 新增
#    - 检测 P-Nvim 添加的 SDK 设置
#    - 询问是否移除
#    - 从 shell 配置文件中删除
```

**结果**：
- ✅ Neovim 配置和数据完全删除
- ✅ P-Nvim 添加的 SDK 配置已清理
- ✅ 用户原有的 SDK 配置保留（如果是手动添加的）

---

### 场景 4：只清理 SDK 配置

```bash
$ ./uninstall.sh

# 选择: 6) 清理 Shell SDK 配置

# 适用场景：
# - 想要手动管理 SDK 配置
# - 重新配置 SDK 路径
# - 保留 Neovim，只清理 SDK 设置

# 流程：
# 1. 检测所有 shell 配置文件
# 2. 识别 P-Nvim 添加的 SDK 配置
# 3. 询问是否移除
# 4. 删除带 P-Nvim 标记的配置
```

**结果**：
- ✅ P-Nvim 的 SDK 配置已清理
- ✅ Neovim 配置和数据保留
- ✅ 可以重新运行 install.sh 或手动配置 SDK

---

## 配置标记说明

### P-Nvim 添加的完整配置块：

```bash
# P-Nvim: macOS SDK 配置 (for Neovim plugins compilation)
# AUTO-GENERATED - DO NOT EDIT MANUALLY
export SDKROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
export CPATH="$SDKROOT/usr/include"
# END P-Nvim SDK Config
```

**特点**：
- 开头和结尾有明确标记
- 警告不要手动编辑
- 卸载时通过标记精确识别和删除

### P-Nvim 添加的单行 CPATH：

```bash
# 用户原有配置
export SDKROOT=/Applications/Xcode.app/.../MacOSX26.0.sdk
export MACOSX_DEPLOYMENT_TARGET=26.0

# P-Nvim 添加
export CPATH="$SDKROOT/usr/include"  # P-Nvim: for Neovim plugins compilation
```

**特点**：
- 在用户现有 SDKROOT 后添加
- 带有 `# P-Nvim:` 标记
- 卸载时通过标记识别和删除

---

## 兼容性

### 支持的 Shell：
- ✅ Zsh (默认，macOS 10.15+)
- ✅ Bash
- ✅ 其他使用 ~/.profile 的 Shell

### 支持的 SDK：
- ✅ Xcode SDK (优先)
- ✅ Command Line Tools SDK
- ✅ 自动检测并使用可用的 SDK

### 支持的系统：
- ✅ macOS Sequoia (26.x)
- ✅ macOS Sonoma (14.x)
- ✅ 其他 macOS 版本（需要 Command Line Tools）

---

## 相关文件

1. **[install.sh](install.sh)** - 一键安装脚本（已集成 SDK 配置）
2. **[uninstall.sh](uninstall.sh)** - 一键卸载脚本（支持清理 SDK 配置）
3. **[fix-compile-headers.sh](fix-compile-headers.sh)** - SDK 修复脚本（独立使用）
4. **[setup-sdk.sh](setup-sdk.sh)** - SDK 诊断脚本（独立使用）
5. **[SDK-CONFIG-FIX.md](SDK-CONFIG-FIX.md)** - SDK 配置详细说明

---

## 测试建议

### 测试用例 1：全新安装
```bash
# 前提：没有 ~/.config/nvim，没有 SDKROOT 配置
./install.sh
# 验证：SDK 配置已添加，插件编译成功
```

### 测试用例 2：重新安装（已有 SDK）
```bash
# 前提：已有 SDKROOT 配置（如你的情况）
./install.sh
# 验证：保留原配置，添加 CPATH，插件编译成功
```

### 测试用例 3：完全卸载
```bash
./uninstall.sh
# 选择 1，验证所有文件和 SDK 配置被清理
```

### 测试用例 4：部分卸载
```bash
./uninstall.sh
# 选择 6，验证只清理 SDK 配置，保留 Neovim 文件
```

---

## 优势

1. **自动化**：无需手动配置 SDK，一键完成
2. **智能**：检测现有配置，避免重复和冲突
3. **安全**：带标记的配置，精确识别和清理
4. **灵活**：支持完全卸载或部分清理
5. **兼容**：尊重用户现有配置，不破坏原有设置

---

## 注意事项

1. **Shell 语法错误**：你的 ~/.zshrc 第 180 行有语法错误（`if; then`），建议修复
2. **重启终端**：修改 shell 配置后需要重启终端或 `source ~/.zshrc`
3. **备份**：建议在完全卸载前选择备份配置
4. **手动配置**：如果已有手动配置的 SDK，脚本会识别并保留

---

## 下一步

现在你可以：

1. **测试安装**：
   ```bash
   ./install.sh
   # 脚本会检测到你的现有 SDKROOT 配置
   # 自动添加 CPATH
   # 使用正确的 SDK 编译所有插件
   ```

2. **测试卸载**：
   ```bash
   ./uninstall.sh
   # 选择 6 测试 SDK 配置清理
   # 或选择 1 测试完全卸载
   ```

3. **查看文档**：
   - [SDK-CONFIG-FIX.md](SDK-CONFIG-FIX.md) - 详细的 SDK 配置说明
   - [QUICKSTART.md](QUICKSTART.md) - 快速入门指南
   - [README.md](README.md) - 完整文档

---

**总结**：SDK 配置功能已完全集成，install.sh 和 uninstall.sh 现在提供了完整的一键安装/卸载体验！🎉
