#!/bin/bash

# Run this shell script to compile the markdown
# files into HTML.

source_dir="./markdown"
destination_dir="./html"

mkdir ${destination_dir}
# remove the existing compiled HTML pages
rm -rf ${destination_dir}/*

for page in `\ls ${source_dir} | cut -d\. -f1`;
    # regenerate the HTML pages
    do pandoc ${source_dir}/${page}.md > ${destination_dir}/${page}.html
done
