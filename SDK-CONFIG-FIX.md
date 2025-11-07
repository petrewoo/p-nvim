# SDK 配置修复说明

## 问题描述

在 macOS 26.0.1 (Sequoia) 系统上，Neovim 插件编译时出现头文件找不到的错误：
```
fatal error: 'stdlib.h' file not found
fatal error: 'stdio.h' file not found
```

## 根本原因

你的系统中存在 **重复的 SDKROOT 配置**，导致环境变量冲突：

- **第 157 行**（原有配置）：
  ```bash
  export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.0.sdk
  ```
  这是你为了 pyenv 安装 Python 而配置的，指向 Xcode 的 macOS 26.0 SDK（正确）

- **第 187 行**（setup-sdk.sh 脚本添加的）：
  ```bash
  export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
  ```
  这是脚本重复添加的，指向 Command Line Tools SDK（虽然也是 26.0 版本，但造成了重复）

后面的 export 会覆盖前面的，造成混淆。

## 修复内容

### 1. 清理 ~/.zshrc 重复配置

**删除了第 187-188 行的重复配置**，保留了你原有的配置并增强：

```bash
# Fix pyenv install python version & Neovim plugins compilation
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.0.sdk
export MACOSX_DEPLOYMENT_TARGET=26.0
export CPATH="$SDKROOT/usr/include"  # 新增：用于 Neovim 插件编译
```

**修改内容**：
- 保留了你原有的 SDKROOT 配置（指向 Xcode MacOSX26.0.sdk）
- 更新了注释，说明这个配置同时用于 pyenv 和 Neovim 插件编译
- 添加了 `CPATH` 环境变量，帮助编译器找到头文件
- 删除了重复的 Command Line Tools SDK 配置

### 2. 更新 fix-compile-headers.sh

修改脚本优先使用 Xcode SDK（如果存在）：

```bash
# 优先使用 Xcode SDK (如果存在)
if [ -d "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.0.sdk" ]; then
    SDK_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.0.sdk"
elif [ -d "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" ]; then
    SDK_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
fi
```

### 3. 改进 setup-sdk.sh

增加了检测现有配置的功能：
- 检查 ~/.zshrc 中是否已存在 SDKROOT 配置
- 如果已配置且路径有效，不再重复添加
- 提供更详细的诊断信息

## 验证修复

运行以下命令验证配置：

```bash
# 1. 检查 SDKROOT 配置
grep "^export SDKROOT" ~/.zshrc

# 输出应该只有一行：
# export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.0.sdk

# 2. 重新加载配置（或重启终端）
source ~/.zshrc

# 3. 验证环境变量
echo $SDKROOT
echo $CPATH

# 4. 运行修复脚本重新编译插件
cd ~/work/toolchains/p-nvim
./fix-compile-headers.sh
```

## SDK 版本信息

你的系统同时安装了：

1. **Xcode SDK**: `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.0.sdk`
   - 实际版本：26.0
   - 通过符号链接指向 MacOSX.sdk

2. **Command Line Tools SDK**: `/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk`
   - 实际版本：26.0 (通过符号链接指向 MacOSX26.0.sdk)
   - 同时还存在旧版本：MacOSX15.5.sdk

**两个 SDK 实际都指向 macOS 26.0 版本，所以功能上是等价的。**

## 为什么选择 Xcode SDK？

保留你原有的 Xcode SDK 配置，因为：
1. 你已经配置好了，用于 pyenv 安装 Python
2. SDK 版本正确（26.0），与系统版本匹配
3. 避免修改已有的工作配置
4. 只需添加 CPATH 即可支持 Neovim 插件编译

## 下一步

1. 重新加载配置：`source ~/.zshrc`（或重启终端）
2. 运行修复脚本：`./fix-compile-headers.sh`
3. 启动 Neovim，检查所有插件是否正常工作

## 注意事项

你的 ~/.zshrc 第 180 行有语法错误：
```bash
if; then  # 这行缺少条件判断
```

这个错误会导致 `source ~/.zshrc` 失败。建议修复或注释掉这段 ssh-agent 相关代码。

---

## 集成到安装/卸载脚本

### 新功能说明

现在 SDK 配置已经集成到 `install.sh` 和 `uninstall.sh` 中：

#### install.sh 新增功能：

1. **自动检测现有 SDK 配置**
   - 安装时会检查 shell 配置文件中是否已有 SDKROOT 配置
   - 如果已配置且有效，则使用现有配置
   - 如果缺少 CPATH，会自动添加（带 P-Nvim 标记）

2. **智能 SDK 配置**
   - 优先检测 Xcode SDK
   - 如果没有 Xcode，则使用 Command Line Tools SDK
   - 添加的配置带有 P-Nvim 标记，方便卸载时清理

3. **编译时自动使用 SDK**
   - 首次安装插件时自动设置 SDK 环境变量
   - 确保所有 C/C++ 插件正确编译

#### uninstall.sh 新增功能：

1. **完全卸载时自动清理 SDK 配置**
   - 选择"完全卸载"时会询问是否移除 P-Nvim 添加的 SDK 配置
   - 只移除带有 P-Nvim 标记的配置，不影响用户原有配置

2. **独立的 SDK 配置清理选项**
   - 菜单新增选项 6：清理 Shell SDK 配置
   - 可以单独清理 SDK 配置而不删除 Neovim 文件

### 使用示例

#### 全新安装：
```bash
./install.sh
# 脚本会：
# 1. 检测系统 SDK
# 2. 询问是否添加 SDK 配置
# 3. 自动使用正确的 SDK 编译插件
```

#### 重新安装（已有 SDK 配置）：
```bash
./install.sh
# 脚本会：
# 1. 检测到现有 SDKROOT 配置
# 2. 验证路径是否有效
# 3. 自动添加 CPATH（如果缺失）
# 4. 使用现有配置编译插件
```

#### 完全卸载：
```bash
./uninstall.sh
# 选择 1) 完全卸载
# 会询问是否移除 P-Nvim 添加的 SDK 配置
```

#### 只清理 SDK 配置：
```bash
./uninstall.sh
# 选择 6) 清理 Shell SDK 配置
# 只移除 P-Nvim 添加的 SDK 设置，保留 Neovim 配置
```

### P-Nvim 添加的 SDK 配置格式

安装脚本添加的配置带有明确的标记：

```bash
# P-Nvim: macOS SDK 配置 (for Neovim plugins compilation)
# AUTO-GENERATED - DO NOT EDIT MANUALLY
export SDKROOT="/path/to/MacOSX.sdk"
export CPATH="$SDKROOT/usr/include"
# END P-Nvim SDK Config
```

或在现有 SDKROOT 后添加的 CPATH：

```bash
export CPATH="$SDKROOT/usr/include"  # P-Nvim: for Neovim plugins compilation
```

卸载时通过这些标记识别并清理。
