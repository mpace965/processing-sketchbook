#!/bin/bash

ffmpeg -r 60 -f image2 -s 750x750 -i "$1/frames/%05d.png" -vcodec libx264 -crf 10 -pix_fmt yuv420p -movflags faststart "$1-output.mp4"
