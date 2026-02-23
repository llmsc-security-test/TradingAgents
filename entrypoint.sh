#!/bin/bash
set -e

echo "Starting TradingAgents HTTP server..."
export PYTHONUNBUFFERED=1
cd /app

exec python http_server.py "$@"
