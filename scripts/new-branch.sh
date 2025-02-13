#!/bin/bash

if [ -z "$1" ]; then
  echo "Ошибка: Не указано название ветки."
  echo "Использование: $0 <название ветки>"
  exit 1
fi

NEW_BRANCH=$1
RELEASE_BRANCH="${NEW_BRANCH}-release"

git checkout main

git checkout --orphan $NEW_BRANCH

echo "Удаление всех файлов, кроме .git..."
git ls-files | grep -v '^.git/' | xargs rm -rf

if git show main:.github > /dev/null 2>&1; then
  git checkout main -- .github
  git add .github
  git commit -m "Перенос папки .github из main в ветку $NEW_BRANCH"
else
  echo "Ошибка: Папка .github отсутствует в ветке main."
  exit 1
fi

git add .
git commit -m "init branch $NEW_BRANCH"
rm -rf *
git checkout -b $RELEASE_BRANCH

echo "Ветка $NEW_BRANCH создана без истории, папка .github перенесена."
echo "Ветка $RELEASE_BRANCH создана от $NEW_BRANCH."

git checkout $NEW_BRANCH