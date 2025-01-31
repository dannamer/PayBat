#!/bin/bash

mkdir -p .tmp/saved/
cp -r .git .tmp/saved/
cd .tmp/saved/
git revert --no-edit .
git checkout main
RELEASE_BRANCHES=$(git branch -r | grep -E 'origin/.*-release$' | sed 's/origin\///')
mkdir -p ../apps/

for branch in $RELEASE_BRANCHES; do
  git checkout $branch
  app_name=$(echo $branch | sed 's/-release$//')
  mkdir -p ../apps/$app_name

  if [ -f .upignore ]; then
    rsync -av --exclude='.git' --exclude='.github' --exclude-from='.upignore' . ../apps/$app_name/
  else
    rsync -av --exclude='.git' --exclude='.github' . ../apps/$app_name/
  fi
done

cd ../..
rm -rf ./.tmp/saved/
mkdir -p ./services/

for app_dir in ./.tmp/apps/*; do
  app_name=$(basename $app_dir)

  if [ -d "./services/$app_name" ]; then
    rm -rf "./services/$app_name"
  fi

  mv "$app_dir" ./services/
done

rm -rf ./.tmp/apps/