#!/bin/bash
cd /Users/dilyslyu/projects/dilyslyu || exit
git pull
git add .
datetime=$(date '+%Y%m%d%H%M%S')
git commit -m "Auto Update By Dilys at $datetime"
git push
exit 0;
