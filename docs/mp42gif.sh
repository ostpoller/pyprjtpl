#!/bin/bash

ifile=$1
ofile=${ifile%.*}.gif

ffmpeg -i ${ifile} -r 5 -vf scale=512:-1 -f image2pipe -vcodec ppm - | convert -deconstruct -delay 20 -loop 0 - ${ofile}
