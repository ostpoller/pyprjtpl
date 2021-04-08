#!/bin/bash

fname=$(basename $1)
fbname=${fname%.*}
pandoc -s -t markdown_github -o ${fbname}.md ${fname}
