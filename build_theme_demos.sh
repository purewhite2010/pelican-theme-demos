#!/bin/bash
THEMES_LOCATION=/home/tim/src/pelican-themes/
for theme in $(ls ~/src/pelican-themes | grep -v README.rst)
do
    echo $theme
    pelican ./content -o $THEMES_LOCATION/$theme/ -s pelicanconf.py -t $THEMES_LOCATION/$theme || echo "FAILED TO BUILD $theme"
done
