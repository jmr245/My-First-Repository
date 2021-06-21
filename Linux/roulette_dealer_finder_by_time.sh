#!/bin/bash
grep $1 $2 | grep $3 | awk -F" " '{print $5, $6}'

# $1 = time
# $2 = date (4 digit num)
# $3 = AM or PM

