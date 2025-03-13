#!/bin/bash

REPO_LIST=~/.repo-autosync.list

if [ ! -f "$REPO_LIST" ]; then
  echo "📄 Список $REPO_LIST не найден. Создаю..."
  touch "$REPO_LIST"
fi

mapfile -t REPOS < "$REPO_LIST"

for REPO in "${REPOS[@]}"; do
  echo "📁 Обрабатываем: $REPO"
  cd "$REPO" || { echo "❌ Не удалось войти в $REPO"; continue; }

  if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    NOW=$(date "+%Y-%m-%d %H:%M:%S")
    echo "🔄 Обнаружены изменения..."
    git add .
    git commit -m "🔁 Auto commit at $NOW" || echo "⚠️ Нечего коммитить"
    git pull --rebase origin main
    git push origin main
    echo "✅ Обновлено и запушено: $REPO"
  else
    echo "✅ Нет изменений в $REPO"
  fi
  echo "-----------------------------------------"
done
