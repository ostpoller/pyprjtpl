#!/bin/bash

fname=$(basename $1)
fbname=${fname%.*}
pandoc -s -t rst -o ${fbname}.rst ${fname}