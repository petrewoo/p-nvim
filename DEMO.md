# P-Nvim 使用演示

这是一个快速演示文档，展示如何在 5 分钟内开始使用 P-Nvim。

## 🎬 第一步：安装

### 选择你的安装方式

**方式 1: 一键安装（推荐新手）**
```bash
git clone https://github.com/petrewoo/p-nvim.git
cd p-nvim
./install.sh
```

**方式 2: 极速安装（老手）**
```bash
git clone https://github.com/petrewoo/p-nvim.git
cd p-nvim
./quick-install.sh
nvim  # 首次启动会自动安装插件，等待 2-3 分钟
```

## 🎯 第二步：首次使用

### 1. 打开 Neovim

```bash
nvim
```

首次启动会看到：
- 🎨 漂亮的启动界面
- ⏳ 插件自动安装（如果是第一次）

### 2. 基础导航

```
# 使用启动界面的快捷键
f - 查找文件
e - 新建文件
r - 最近文件
g - 全局搜索
c - 编辑配置
q - 退出
```

## 📁 第三步：文件浏览

### 打开文件浏览器

```
按 <Space>e （空格键 + e）
```

你会看到左侧弹出文件树。

### 文件树操作

```
j/k      - 上下移动
Enter    - 打开文件/文件夹
a        - 新建文件
d        - 删除文件
r        - 重命名
x        - 剪切
c        - 复制
p        - 粘贴
R        - 刷新
?        - 查看帮助
q 或 <Space>e  - 关闭文件树
```

### 实操演示

1. 按 `<Space>e` 打开文件树
2. 按 `a` 创建新文件，输入 `test.py`
3. 按 `Enter` 打开文件
4. 输入一些 Python 代码
5. 按 `<Space>w` 保存

## 🔍 第四步：查找文件

### 快速查找

```
Ctrl-p  或  ,ff
```

会弹出一个模糊搜索界面。

### 操作方式

```
输入文件名（支持模糊匹配）
Ctrl-j/k  - 上下移动
Enter     - 打开文件
Esc       - 关闭
```

### 实操演示

1. 按 `Ctrl-p`
2. 输入 "core"
3. 看到 `core.lua` 被高亮
4. 按 `Enter` 打开

## 🔎 第五步：全局搜索

### 搜索文本

```
,fg  （逗号 + f + g）
```

### 操作方式

```
输入要搜索的文本
Ctrl-j/k  - 浏览结果
Enter     - 跳转到该位置
```

### 实操演示

1. 按 `,fg`
2. 输入 "leader"
3. 看到所有包含 "leader" 的文件
4. 选择一个按 `Enter` 跳转

## ✏️ 第六步：编辑代码

### 基础编辑

创建一个 Python 文件测试：

```python
def hello():
    print("Hello, World!")

hello()
```

### 自动补全

1. 开始输入 `def`
2. 会自动弹出补全菜单
3. 按 `Tab` 选择
4. 按 `Enter` 确认

### 代码片段

1. 输入 `for`
2. 选择 for 循环片段
3. 按 `Tab` 跳转到下一个占位符

### 注释代码

```
gcc  - 注释/取消注释当前行
gc   - 注释选中的代码（可视模式）
```

实操：
1. 将光标放在任意行
2. 按 `gcc`
3. 该行被注释
4. 再按 `gcc`
5. 注释被取消

## 🎓 第七步：LSP 功能

### 准备工作：安装 LSP 服务器

```vim
:Mason
```

在 Mason 界面：
- 按 `/` 搜索
- 输入 "pyright"（Python LSP）
- 按 `i` 安装
- 等待安装完成
- 按 `q` 退出

### 使用 LSP

打开一个 Python 文件：

```python
import os

def get_path():
    return os.path.abspath(".")

print(get_path())
```

### LSP 功能演示

**1. 查看文档**
- 将光标放在 `os.path` 上
- 按 `K`
- 看到函数文档

**2. 跳转到定义**
- 将光标放在 `get_path()` 调用上
- 按 `gd`
- 跳转到函数定义

**3. 查看引用**
- 将光标放在函数名上
- 按 `gr`
- 看到所有调用该函数的位置

**4. 重命名**
- 将光标放在 `get_path` 上
- 按 `,rn`
- 输入新名字 `get_current_path`
- 所有引用都会被重命名

**5. 代码格式化**
- 按 `,f`
- 代码自动格式化

## 🔀 第八步：Git 操作

### 查看 Git 状态

```
,gs  - Git status
```

### Git 操作

```
,gd  - Git diff
,gb  - Git blame
,gc  - Git commit
,gp  - Git push
```

### 查看改动

编辑文件后，左侧会显示：
- `│` 绿色 - 新增的行
- `│` 蓝色 - 修改的行
- `_` 红色 - 删除的行

### Hunk 操作

```
]c       - 跳转到下一个改动
[c       - 跳转到上一个改动
,hp      - 预览改动
,hs      - 暂存改动
,hr      - 撤销改动
```

## 🪟 第九步：窗口管理

### 分屏

```vim
:vsplit    - 垂直分屏
:split     - 水平分屏
```

### 窗口导航

```
Ctrl-h  - 左边窗口
Ctrl-j  - 下边窗口
Ctrl-k  - 上边窗口
Ctrl-l  - 右边窗口
```

### 调整窗口大小

```
Ctrl-Up     - 增加高度
Ctrl-Down   - 减少高度
Ctrl-Left   - 减少宽度
Ctrl-Right  - 增加宽度
```

### 实操演示

1. 按 `:vsplit` 垂直分屏
2. 按 `Ctrl-h` 切换到左边
3. 按 `Ctrl-l` 切换到右边
4. 按 `Ctrl-Right` 增加右边窗口宽度

## 📑 第十步：标签页和缓冲区

### 标签页操作

```
tn       - 新建标签页
td       - 关闭标签页
tj       - 下一个标签页
tk       - 上一个标签页
,1-9     - 跳转到第 1-9 个标签页
```

### 缓冲区操作

```
]b       - 下一个缓冲区
[b       - 上一个缓冲区
,bd      - 关闭当前缓冲区
,fb      - 查找缓冲区
```

## 🎨 实用技巧

### 1. 多光标编辑

1. 选中一个词（可视模式 `v`）
2. 按 `Ctrl-n` 选择下一个相同的词
3. 继续按 `Ctrl-n` 选择更多
4. 开始编辑

### 2. 快速跳转

```
,hw  - Hop 跳转到单词
,hl  - Hop 跳转到行
,hc  - Hop 跳转到字符
```

### 3. 对齐代码

1. 选中要对齐的行（可视模式）
2. 按 `ga`
3. 输入对齐字符（如 `=`）

### 4. 撤销树

```
,u  - 打开撤销树
```

可以看到完整的编辑历史。

### 5. 代码大纲

```
,a  - 打开代码大纲
```

显示当前文件的函数、类等结构。

## 💡 常用快捷键速查

### 文件操作
```
<Space>e  文件浏览器
Ctrl-p    查找文件
<Space>fg 全局搜索
<Space>w  保存
<Space>q  退出
```

### 编辑
```
kj       退出插入模式
gcc      注释行
H/L      行首/行尾
,y       复制到系统剪贴板
```

### 导航
```
gd       跳转定义
gr       查看引用
K        查看文档
,rn      重命名
```

### Git
```
,gs      Git status
,gd      Git diff
]c/[c    下一个/上一个改动
```

### 窗口
```
Ctrl-h/j/k/l  窗口导航
:vsplit       垂直分屏
:split        水平分屏
```

## 🆘 遇到问题？

### 检查配置健康

```vim
:checkhealth
```

### 查看 LSP 状态

```vim
:LspInfo
```

### 查看插件状态

```vim
:Lazy
```

### 更新插件

```vim
:Lazy update
```

### 重装插件

```vim
:Lazy clean
:Lazy sync
```

## 📚 下一步学习

1. 阅读 [QUICKSTART.md](QUICKSTART.md) 了解更多快捷键
2. 查看 [README.md](README.md) 了解完整功能
3. 参考 [INSTALL.md](INSTALL.md) 解决安装问题
4. 浏览 [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) 了解配置结构

## 🎯 5 分钟挑战

现在你已经学会了基础操作，试试这个 5 分钟挑战：

1. ✅ 创建一个新的 Python 文件
2. ✅ 写一个简单的函数
3. ✅ 使用自动补全
4. ✅ 查看函数文档 (K)
5. ✅ 格式化代码 (<Space>f)
6. ✅ 注释一行代码 (gcc)
7. ✅ 全局搜索一个词 (<Space>fg)
8. ✅ 分屏打开另一个文件
9. ✅ 在窗口间切换 (Ctrl-h/l)
10. ✅ 保存并退出 (<Space>w :q)

完成了吗？恭喜你已经掌握了 P-Nvim 的基础！🎉

---

**提示**: 不要试图一次记住所有快捷键。先掌握最常用的 10 个，然后逐步学习其他功能。常用操作会形成肌肉记忆，很快就能熟练使用。
