#!/bin/bash
DOWNLOADDIR=DOWNLOADS
if [ -z "$1" ]
  then
    echo "No argument supplied"
    echo "Usage: downloadstuff.sh <INPUTFILE WITH URLS TO DOWNLOAD>"
    exit 13
fi
INFILE=$1
if [ -e "$INFILE" ]
then
    echo "Using $INFILE..."
else
    echo "Input file $INFILE does not exist..."
    exit 13
fi
if [ ! -d "$DOWNLOADDIR" ]; then
  mkdir "$DOWNLOADDIR"
fi
echo "Downloading stuff..."
while read p || [[ -n $p ]]; do
  tmp=${p:7}
  bnl=`awk -v a="$tmp" -v b="." 'BEGIN{print index(a,b)}'`
  bucketname=${tmp:0:bnl-1}
  echo "Downloading from $bucketname"
  cd $DOWNLOADDIR/ && { wget -x $p ; cd -; }
done<$INFILE