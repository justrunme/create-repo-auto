#!/bin/bash
set -e

echo "🚀 Installing create-repo-auto..."

# Download the latest binary
curl -LO https://github.com/justrunme/create-repo-auto/releases/latest/download/create-repo-auto_1.3.0.deb

# Установка deb-пакета
sudo dpkg -i create-repo-auto_1.3.0.deb

# Удаление файла после установки
rm create-repo-auto_1.3.0.deb

echo "✅ create-repo-auto успешно установлен!"
