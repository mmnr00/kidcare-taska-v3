#!/bin/bash
git checkout 0-dev
git add -A
git commit -m "tsk"
git push

git checkout 0-stg
git merge 0-dev
git push

git checkout production_n
git merge 0-stg
git push

git diff HEAD 0-stg
git diff HEAD 0-dev
git checkout 0-dev
