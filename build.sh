#!/bin/bash

# Run this shell script to compile the markdown
# files into HTML.

source_dir="./markdown"
destination_dir="./html"

# remove the existing compiled HTML pages
rm -rf ${destination_dir}/*

for md in `\ls ${source_dir} | cut -d\. -f1`;
    # regenerate the HTML pages
    do pandoc ${source_dir}/${md}.md > ${destination_dir}/${md}.html
done
