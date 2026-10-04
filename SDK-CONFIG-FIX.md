# SDK 配置说明

## 问题

在 macOS 上编译 Neovim 插件时，可能出现找不到系统头文件的错误：

    fatal error: 'stdlib.h' file not found
    fatal error: 'stdio.h' file not found

原因是编译器不知道 macOS SDK 的位置。解决办法是设置 `SDKROOT` 和 `CPATH` 两个环境变量。

## 不要写死 SDK 路径

SDK 的路径里带版本号，例如 `MacOSX26.0.sdk`。系统或 Xcode 升级后这个路径就不存在了，
写死的配置会让所有编译重新失败。所以本项目的脚本一律用 `xcrun` 在运行时检测：

    export SDKROOT="$(env -u SDKROOT xcrun --show-sdk-path 2>/dev/null)"
    export CPATH="$SDKROOT/usr/include"

`env -u SDKROOT` 不能省：如果环境里已经有 `SDKROOT`，`xcrun` 会原样返回它，
在 tmux 或嵌套 shell 里就会一直沿用过期的值。

`xcrun` 返回哪个 SDK 由 `xcode-select -p` 决定，可能是 Command Line Tools 的，
也可能是 Xcode.app 的。两者都可以。

## 各脚本的行为

| 脚本 | 行为 |
|---|---|
| `install.sh` | 用 `xcrun` 为本次安装设置环境变量。shell 配置里已有 SDK 设置时不做修改，否则询问后追加上面的自适应配置 |
| `fix-compile-headers.sh` | 用 `xcrun` 检测 SDK，清理失败的编译产物，重新编译插件 |
| `setup-sdk.sh` | 诊断当前的 SDK 配置。shell 配置已是自适应写法时直接退出 |
| `uninstall.sh` | 清理 `install.sh` 追加的、带 `P-Nvim` 标记的配置块 |

## 与 ecosystem 配合使用

通过 `ecosystem` 仓库的 `install.sh` 安装时，`~/.zshrc` 由 `ecosystem` 管理，
其中已包含自适应的 SDK 配置，`~/.config/nvim` 是指向本仓库 `nvim/` 的软链。
此时本仓库的 `install.sh` 会识别这两点，既不复制配置，也不修改 `~/.zshrc`。

## 排查

    xcode-select -p                        # 当前选用的开发工具
    env -u SDKROOT xcrun --show-sdk-path   # 实际生效的 SDK
    echo $SDKROOT; echo $CPATH             # 当前 shell 里的值
    ls "$SDKROOT/usr/include/stdio.h"      # 头文件是否存在

仍有问题时运行 `./fix-compile-headers.sh`。
