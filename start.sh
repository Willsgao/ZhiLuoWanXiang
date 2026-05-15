#!/bin/bash
# ==========================================
#  知罗万象 (ZhiLuoWanXiang) 启动脚本
#  知识图谱自动生成工具
# ==========================================


echo "========================================"
echo "  知罗万象 - 知识万象图谱"
echo "  ZhiLuoWanXiang v1.0 (SQLite)"
echo "========================================"
echo ""

source /data/venv/bin/activate
cd /data/ZhiLuoWanXiang

nohup python3 app.py &

echo "服务已启动"