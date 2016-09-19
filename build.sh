#!/bin/bash

# Run this shell script to compile the markdown
# files into HTML.

source_dir="./source"
html_dir="./html"

for md in `\ls ${source_dir} | cut -d\. -f1`;
    do pandoc ${source_dir}/${md}.md > ${html_dir}/${md}.html
done
