#!/bin/bash
git checkout 10dev
git add -A
git commit -m "tsk"
git push

git checkout 10stg
git merge 10dev
git push

git checkout production_n
git merge 10stg
git push

git diff HEAD 10stg
git diff HEAD 10dev
git checkout 10dev
