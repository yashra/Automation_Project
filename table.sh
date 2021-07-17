#!/bin/bash

# Run as: table.sh < {input-file-name} > {output-file-name}
# The script requires a space-delimited data file to parse into an html table.
# It does not automatically create a header row.

echo \<table style="width:100%"\>
while read line; do
    echo \<tr\>
    for item in $line; do
        echo \<td\>$item\<\/td\>
    done
    echo \<\/tr\>
done
echo \<\/table\>
