#!/bin/bash

root_url=https://improbable-podcast.lepodcast.fr/page

echo "Root URL: $root_url"

n_pages=$(curl -s $root_url/1 | grep -oP "(?<=<a href=\"/page/)[0-9]*(?=\">)" | tail -n 1)

echo "Max page number: $n_pages"

for (( i=0; i<=$n_pages; i++ ))
do
    echo "Page en cours: $i/$n_pages"
    for file in $(curl -s $root_url/$i | grep -oP "(?<=href=\")https://stats\.podcloud\.fr/improbable-podcast/.*\.mp3")
    do
        name=$(echo $file | grep -oP "(?<=https://stats\.podcloud\.fr/improbable-podcast/).*(?=/.*\.mp3)").mp3
        if [ ! -f $name ]
        then
            wget $file -O $name
        fi
    done
done
