#!/bin/bash

# Claude AI 快速设置脚本

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Claude AI 快速设置向导${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo

# 检查 API Key
if [ -n "$ANTHROPIC_API_KEY" ]; then
    echo -e "${GREEN}✓${NC} 已检测到 ANTHROPIC_API_KEY 环境变量"
    echo "  API Key: ${ANTHROPIC_API_KEY:0:10}..."
else
    echo -e "${YELLOW}!${NC} 未检测到 ANTHROPIC_API_KEY 环境变量"
    echo
    echo "请按以下步骤设置："
    echo "1. 访问 https://console.anthropic.com/"
    echo "2. 创建或登录账号"
    echo "3. 进入 API Keys 页面"
    echo "4. 创建新的 API Key"
    echo "5. 复制 API Key"
    echo
    read -p "请粘贴你的 API Key (sk-ant-...): " api_key
    
    if [ -z "$api_key" ]; then
        echo "未输入 API Key，退出"
        exit 1
    fi
    
    # 确定 shell 配置文件
    if [ -f ~/.zshrc ]; then
        shell_config=~/.zshrc
    elif [ -f ~/.bashrc ]; then
        shell_config=~/.bashrc
    else
        shell_config=~/.profile
    fi
    
    echo
    echo "将 API Key 添加到 $shell_config"
    echo "export ANTHROPIC_API_KEY=\"$api_key\"" >> "$shell_config"
    echo -e "${GREEN}✓${NC} API Key 已添加"
    echo
    echo "请运行以下命令使其生效:"
    echo "  source $shell_config"
    echo
    read -p "按 Enter 继续..."
fi

echo
echo "检查依赖..."

# 检查 make
if command -v make &> /dev/null; then
    echo -e "${GREEN}✓${NC} make 已安装"
else
    echo -e "${YELLOW}!${NC} make 未安装"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  请运行: xcode-select --install"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "  请运行: sudo apt install build-essential"
    fi
    exit 1
fi

# 检查 curl
if command -v curl &> /dev/null; then
    echo -e "${GREEN}✓${NC} curl 已安装"
else
    echo -e "${YELLOW}!${NC} curl 未安装，请先安装"
    exit 1
fi

echo
echo "启动 Neovim 安装 AI 插件..."
echo "这可能需要几分钟时间..."
echo

# 启动 Neovim 安装插件
nvim --headless "+Lazy! sync" +qa

echo
echo -e "${GREEN}════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  设置完成！${NC}"
echo -e "${GREEN}════════════════════════════════════════════════${NC}"
echo
echo "快捷键:"
echo "  ,aa  - 打开 AI 助手"
echo "  ,ae  - 解释代码"
echo "  ,ao  - 优化代码"
echo "  ,af  - 查找 Bug"
echo "  ,au  - 生成测试"
echo
echo "详细文档: cat CLAUDE_AI.md"
echo
echo "现在可以启动 Neovim 使用 Claude AI 了！"
echo

