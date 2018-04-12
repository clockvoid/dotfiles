#!/bin/sh

#maim -s $1/Screenshot_at_$(date +%Y-%m-%d-%H-%M-%S).png
maim -s | convert - \( +clone -background black -shadow 60x30+0+10 \) +swap -background white -layers merge +repage $1/Screenshot_at_$(date +%Y-%m-%d-%H-%M-%S).png
