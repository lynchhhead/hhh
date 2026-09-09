#!/bin/bash
echo "=== Начинаю деплой ==="
git pull origin main
pip install -r requirements.txt
echo "=== Деплой завершен! ==="