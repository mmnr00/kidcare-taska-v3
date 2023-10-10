#!/bin/bash
git checkout 10dev
git add -A
git commit -m "tsk"
git push

git checkout stg_n
git merge 10dev
git push

git checkout production_n
git merge stg_n
git push

git diff HEAD stg_n
git diff HEAD 10dev
git checkout 10dev
