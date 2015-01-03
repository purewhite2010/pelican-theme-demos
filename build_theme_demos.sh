#!/bin/bash 
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
THEMES_LOCATION=/home/tim/src/pelican-themes/

echo '<!DOCTYPE html>
<html>
<head>
<link rel=stylesheet href="style.css" type="text/css"/>
</head>
<body>

<ul>' > demo/index.html
cp style.css demo/

for theme in $(ls ~/src/pelican-themes | grep -v README.rst)
do
    echo $theme
    sed "s/THEME_NAME/$theme/" pelicanconf.py > /tmp/pelicanconf.py
    pelican ./content -o ./demo/$theme/ -s /tmp/pelicanconf.py -t $THEMES_LOCATION/$theme || echo "FAILED TO BUILD $theme"
    rm /tmp/pelicanconf.py*
    pushd ./demo/$theme/
    python -m SimpleHTTPServer 8000 &> /dev/null &
    python_server=$!
    while ! curl http://localhost:8000 &> /dev/null; do echo 1; sleep 0.2; done
    timeout 5 phantomjs $DIR/capture.js 
    kill -9 $python_server
    popd
    echo "<li><a href='./$theme'><h3>$theme</h3> <img src='./$theme/shot.png'/></a></li>" >> demo/index.html
done

echo '</ul></body></html>' >> demo/index.html
