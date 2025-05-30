#!/bin/bash
git add .
shuf -n 1 ./gitCMT.txt | xargs -I{} git commit -m {}
git status
echo waiting for push.
