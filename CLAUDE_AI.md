# Claude AI 集成指南

P-Nvim 已集成 Claude AI 助手，让你可以在编辑器中直接使用 Claude 的强大功能。

## 📋 目录

- [功能特性](#功能特性)
- [前置要求](#前置要求)
- [安装配置](#安装配置)
- [使用方法](#使用方法)
- [快捷键](#快捷键)
- [常见用途](#常见用途)
- [故障排除](#故障排除)

---

## 功能特性

### Avante.nvim - Claude AI 集成

✨ **核心功能**:
- 💬 在编辑器中与 Claude 对话
- 🔍 代码解释和分析
- ✍️ 代码生成和补全
- 🐛 Bug 查找和修复
- 📝 代码重构建议
- 📚 文档生成
- 🧪 单元测试生成
- 💡 代码优化建议

✨ **特色**:
- 使用最新的 Claude Sonnet 4.5 模型
- 支持上下文感知
- 支持差异对比（diff）
- 支持图片粘贴
- Markdown 渲染
- 侧边栏界面

---

## 前置要求

### 1. 系统要求

- Neovim >= 0.9.0
- Git
- Make (用于构建插件)
- Curl

**macOS**:
```bash
# 已预装 make 和 curl
xcode-select --install  # 如果需要
```

**Linux**:
```bash
# Ubuntu/Debian
sudo apt install build-essential curl

# Arch
sudo pacman -S base-devel curl

# Fedora
sudo dnf install make gcc curl
```

### 2. Claude API Key

你需要一个 Anthropic Claude API Key。

**获取步骤**:
1. 访问 https://console.anthropic.com/
2. 注册或登录账号
3. 进入 API Keys 页面
4. 创建新的 API Key
5. 复制 API Key（格式: `sk-ant-...`）

**定价**:
- Claude Sonnet 4.5: 按使用量计费
- 查看最新价格: https://www.anthropic.com/pricing

---

## 安装配置

### 步骤 1: 安装插件

插件已经包含在配置中，首次启动 Neovim 时会自动安装。

如果已经安装了 P-Nvim，运行：
```vim
:Lazy sync
```

等待 Avante.nvim 安装完成（可能需要几分钟，因为需要编译）。

### 步骤 2: 配置 API Key

**方法 1: 环境变量（推荐）**

编辑你的 shell 配置文件：

```bash
# ~/.bashrc 或 ~/.zshrc
export ANTHROPIC_API_KEY="sk-ant-your-api-key-here"
```

然后重新加载：
```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

**方法 2: 配置文件**

编辑 `~/.config/nvim/lua/plugins/ai.lua`:

```lua
opts = {
  provider = "claude",
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-sonnet-4-5-20250929",
    temperature = 0,
    max_tokens = 8000,
    api_key_name = "ANTHROPIC_API_KEY",  -- 或直接设置 api_key = "sk-ant-..."
  },
  -- ...
},
```

**安全提示**: 不要把 API Key 直接写在配置文件中并提交到 Git！

### 步骤 3: 验证安装

启动 Neovim：
```bash
nvim
```

检查插件状态：
```vim
:Lazy
```

确认 `avante.nvim` 已安装并加载。

---

## 使用方法

### 基本使用

#### 1. 打开 AI 助手

在 Neovim 中，使用命令：
```vim
:AvanteAsk
```

或使用快捷键（下文会设置）。

#### 2. 与 Claude 对话

在打开的侧边栏中：
1. 输入你的问题或需求
2. 按 `<CR>` (Enter) 发送
3. 等待 Claude 回复
4. 查看建议和代码

#### 3. 应用代码建议

当 Claude 提供代码时：
- 按 `co` - 接受我们的版本（保留原代码）
- 按 `ct` - 接受他们的版本（使用 Claude 的代码）
- 按 `cb` - 保留两者
- 按 `cc` - 在光标处选择

### 常用命令

```vim
:AvanteAsk              " 打开 AI 助手
:AvanteChat             " 开始对话
:AvanteClear            " 清除对话历史
:AvanteToggle           " 切换显示/隐藏
:AvanteRefresh          " 刷新
:AvanteSwitchProvider   " 切换 AI 提供商
```

---

## 快捷键

### 推荐的快捷键配置

编辑 `~/.config/nvim/lua/keymaps.lua`，添加：

```lua
-- AI 助手快捷键
local ai_opts = { noremap = true, silent = true }

-- 打开 AI 助手
keymap('n', '<leader>aa', ':AvanteAsk<CR>', ai_opts)
keymap('v', '<leader>aa', ':AvanteAsk<CR>', ai_opts)

-- AI 聊天
keymap('n', '<leader>ac', ':AvanteChat<CR>', ai_opts)

-- 清除历史
keymap('n', '<leader>ax', ':AvanteClear<CR>', ai_opts)

-- 切换显示
keymap('n', '<leader>at', ':AvanteToggle<CR>', ai_opts)

-- 快速操作
keymap('n', '<leader>ae', ':AvanteAsk explain this code<CR>', ai_opts)
keymap('v', '<leader>ae', ':AvanteAsk explain this code<CR>', ai_opts)

keymap('n', '<leader>ao', ':AvanteAsk optimize this code<CR>', ai_opts)
keymap('v', '<leader>ao', ':AvanteAsk optimize this code<CR>', ai_opts)

keymap('n', '<leader>af', ':AvanteAsk find bugs in this code<CR>', ai_opts)
keymap('v', '<leader>af', ':AvanteAsk find bugs in this code<CR>', ai_opts)

keymap('n', '<leader>ad', ':AvanteAsk add documentation<CR>', ai_opts)
keymap('v', '<leader>ad', ':AvanteAsk add documentation<CR>', ai_opts)

keymap('n', '<leader>au', ':AvanteAsk write unit tests<CR>', ai_opts)
keymap('v', '<leader>au', ':AvanteAsk write unit tests<CR>', ai_opts)
```

### 快捷键速查

| 快捷键 | 功能 |
|--------|------|
| `,aa` | 打开 AI 助手 |
| `,ac` | 开始聊天 |
| `,at` | 切换显示 |
| `,ax` | 清除历史 |
| `,ae` | 解释代码 |
| `,ao` | 优化代码 |
| `,af` | 查找 Bug |
| `,ad` | 添加文档 |
| `,au` | 生成测试 |

**差异对比模式**:
| 快捷键 | 功能 |
|--------|------|
| `co` | 保留原代码 |
| `ct` | 使用 AI 建议 |
| `cb` | 保留两者 |
| `cc` | 在光标处选择 |
| `]x` | 下一个差异 |
| `[x` | 上一个差异 |

---

## 常见用途

### 1. 代码解释

**场景**: 看不懂某段复杂代码

**操作**:
1. 选中代码（可视模式 `v`）
2. 按 `,ae`
3. Claude 会详细解释代码逻辑

**示例**:
```python
# 选中这段代码然后按 ,ae
def fibonacci(n):
    return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)
```

### 2. 代码优化

**场景**: 代码可以运行但效率不高

**操作**:
1. 选中代码
2. 按 `,ao`
3. Claude 会提供优化建议

**示例**:
```python
# 选中后按 ,ao，Claude 会建议使用动态规划或记忆化
def fibonacci(n):
    return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)
```

### 3. Bug 查找

**场景**: 代码有问题但找不到原因

**操作**:
1. 选中相关代码
2. 按 `,af`
3. Claude 会分析潜在问题

### 4. 文档生成

**场景**: 需要为函数添加文档

**操作**:
1. 选中函数
2. 按 `,ad`
3. Claude 会生成文档注释

**示例**:
```python
# 选中函数后按 ,ad
def calculate_total(items, tax_rate):
    subtotal = sum(item['price'] for item in items)
    tax = subtotal * tax_rate
    return subtotal + tax

# Claude 会添加:
"""
Calculate the total cost including tax.

Args:
    items: List of items with 'price' key
    tax_rate: Tax rate as decimal (e.g., 0.08 for 8%)

Returns:
    Total cost including tax
"""
```

### 5. 单元测试

**场景**: 需要为代码编写测试

**操作**:
1. 选中函数
2. 按 `,au`
3. Claude 会生成单元测试

### 6. 代码重构

**场景**: 代码需要重构

**步骤**:
1. 打开 AI 助手: `,aa`
2. 输入: "Refactor this code to use better patterns"
3. 选中代码并按 Enter
4. 查看建议并应用

### 7. 学习新概念

**场景**: 想了解某个技术概念

**操作**:
1. 按 `,ac` 开始聊天
2. 输入问题，如: "Explain async/await in Python"
3. Claude 会详细解答

### 8. 代码生成

**场景**: 从零开始编写功能

**操作**:
1. 按 `,aa`
2. 描述需求: "Write a function to validate email addresses"
3. Claude 会生成代码
4. 使用 `ct` 接受建议

---

## 实际工作流程

### 工作流 1: 阅读和理解代码

```
1. 打开包含复杂代码的文件
2. 选中不理解的部分
3. 按 ,ae 请求解释
4. 阅读 Claude 的解释
5. 根据需要提问
```

### 工作流 2: 调试问题

```
1. 发现代码有 bug
2. 选中可能有问题的代码
3. 按 ,af 查找问题
4. Claude 指出问题并提供修复
5. 使用 ct 应用修复
6. 运行测试验证
```

### 工作流 3: 优化性能

```
1. 识别性能瓶颈
2. 选中相关代码
3. 按 ,ao 请求优化
4. 比较原代码和优化后的代码
5. 使用 ]x 和 [x 浏览差异
6. 选择性应用改进（co/ct/cb）
```

### 工作流 4: 编写新功能

```
1. 按 ,aa 打开 AI 助手
2. 描述功能需求
3. Claude 生成代码框架
4. 按 ct 接受建议
5. 继续对话完善细节
6. 按 ,au 生成测试
```

---

## 配置选项

### 修改模型

编辑 `~/.config/nvim/lua/plugins/ai.lua`:

```lua
claude = {
  model = "claude-sonnet-4-5-20250929",  -- 最新最强
  -- 或使用其他模型:
  -- model = "claude-3-5-sonnet-20241022",  -- 较旧但更便宜
  -- model = "claude-3-opus-20240229",      -- 最强但最贵
  temperature = 0,      -- 0 = 更确定，1 = 更创造性
  max_tokens = 8000,    -- 最大响应长度
},
```

### 修改窗口位置

```lua
windows = {
  position = "right",  -- 可选: "left", "top", "bottom"
  width = 30,          -- 宽度百分比
},
```

### 关闭自动建议

```lua
behaviour = {
  auto_suggestions = false,  -- 设为 true 启用自动建议
},
```

---

## 故障排除

### 问题 1: 插件安装失败

**症状**: `:Lazy sync` 时报错

**解决方法**:
```bash
# 确保安装了 build 工具
# macOS
xcode-select --install

# Linux
sudo apt install build-essential  # Ubuntu/Debian
sudo pacman -S base-devel         # Arch

# 重新安装
nvim
:Lazy clean
:Lazy sync
```

### 问题 2: API Key 无效

**症状**: 报错 "Authentication failed"

**解决方法**:
1. 检查 API Key 是否正确
2. 确认环境变量已设置:
```bash
echo $ANTHROPIC_API_KEY
```
3. 重启 Neovim

### 问题 3: 无响应

**症状**: 发送请求后长时间无响应

**解决方法**:
1. 检查网络连接
2. 检查 API 配额:
```bash
curl https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01"
```
3. 查看错误日志:
```vim
:messages
```

### 问题 4: 侧边栏不显示

**症状**: 命令执行了但看不到界面

**解决方法**:
```vim
:AvanteToggle  " 尝试切换
:AvanteRefresh " 刷新
```

### 问题 5: 编译失败

**症状**: `make` 失败

**解决方法**:
```bash
# 进入插件目录
cd ~/.local/share/nvim/lazy/avante.nvim

# 手动编译
make clean
make

# 如果还是失败，查看详细错误
make BUILD_TYPE=debug
```

---

## 最佳实践

### 1. 清晰的提示词

❌ **不好**:
```
fix this
```

✅ **好**:
```
Find and fix any bugs in this Python function.
Pay attention to edge cases and type errors.
```

### 2. 提供上下文

选中足够的代码让 Claude 理解上下文，但不要太多。

### 3. 迭代改进

先生成基础代码，然后通过对话逐步改进。

### 4. 验证建议

始终验证 Claude 的建议，不要盲目接受。

### 5. 保护隐私

不要发送敏感信息（密码、API Key、私密数据）给 AI。

---

## 高级用法

### 自定义提示词模板

创建 `~/.config/nvim/lua/ai_prompts.lua`:

```lua
return {
  explain = "Explain this {{language}} code in detail:\n\n{{code}}",
  optimize = "Optimize this {{language}} code for performance:\n\n{{code}}",
  tests = "Write comprehensive unit tests for:\n\n{{code}}",
  document = "Add detailed documentation:\n\n{{code}}",
  refactor = "Refactor this code following best practices:\n\n{{code}}",
}
```

### 批量处理

使用宏结合 AI 功能批量处理多个文件。

### 集成到工作流

在 CI/CD 中使用 Claude API 进行代码审查。

---

## 资源链接

- [Avante.nvim GitHub](https://github.com/yetone/avante.nvim)
- [Claude API 文档](https://docs.anthropic.com/)
- [Claude 控制台](https://console.anthropic.com/)
- [定价信息](https://www.anthropic.com/pricing)

---

## 更新日志

### 2025-01-06
- ✅ 集成 Avante.nvim
- ✅ 配置 Claude Sonnet 4.5
- ✅ 添加快捷键
- ✅ 创建使用文档

---

## 💡 提示

记住这些快捷键，它们会极大提高你的编码效率：

- `,aa` - 打开 AI 助手
- `,ae` - 解释代码
- `,ao` - 优化代码
- `,af` - 查找 Bug
- `,au` - 生成测试

**祝你使用愉快！如果有任何问题，查看故障排除部分或提 Issue。** 🚀
