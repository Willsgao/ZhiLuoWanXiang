#!/bin/bash
# ==========================================
#  知罗万象 (ZhiLuoWanXiang) 启动脚本
#  知识图谱自动生成工具
# ==========================================

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

echo "========================================"
echo "  知罗万象 - 知识万象图谱"
echo "  ZhiLuoWanXiang v1.0 (SQLite)"
echo "========================================"
echo ""

# 检查 .env 文件
if [ ! -f ".env" ]; then
    echo "[WARNING] 未找到 .env 文件！"
    echo "请创建 .env 文件并配置大模型 API KEY，例如："
    echo ""
    echo "  deepseek_API_KEY=your_key_here"
    echo "  silconflow_API_KEY=your_key_here"
    echo "  DASHSCOPE_API_KEY=your_key_here"
    echo "  OpenAI_API_KEY=your_key_here"
    echo ""
    read -p "按 Enter 继续（将使用默认配置启动）..." dummy
fi

# 检查 Python 环境
if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "[ERROR] 未找到 Python，请先安装 Python 3.7+"
    exit 1
fi

PYTHON_CMD=$(command -v python3 || command -v python)
echo "[INFO] 使用 Python: $PYTHON_CMD"

# 检查并安装依赖
if [ ! -d "venv" ] && [ -z "$VIRTUAL_ENV" ]; then
    echo "[INFO] 未检测到虚拟环境，建议创建："
    echo "  python3 -m venv venv && source venv/bin/activate"
    echo ""
fi

echo "[INFO] 检查依赖..."
$PYTHON_CMD -c "import flask" 2>/dev/null || {
    echo "[INFO] 正在安装依赖..."
    $PYTHON_CMD -m pip install -r requirements.txt
}

# 创建日志目录
mkdir -p logs

echo ""
echo "[INFO] 启动 Flask 服务..."
echo "[INFO] 访问地址: http://localhost:5000"
echo "[INFO] 按 Ctrl+C 停止服务"
echo ""

$PYTHON_CMD app.py
