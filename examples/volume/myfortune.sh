#!/bin/bash

declare -a lines
declare -i idx=0

while read -ed% line
do
	lines[$idx]=$line
	idx=$((idx + 1))
done < fortunes

total=${#lines[*]}
echo "* total lines: $total"
randomIdx=$(($RANDOM % $total))
echo "* random $randomIdx: ${lines[$randomIdx]}"
