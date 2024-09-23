#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-to-I-screen-shoter.sh <SubdomainList(example.com-live-domain.txt)>"
    exit
fi

file_name=` echo $1 |  sed "s/.txt//g" `


echo "Start Run httpx for take favicon from urls in file $1"

cat $1 | httpx -favicon -follow-redirects -threads 40 -rate-limit 10 -silent -filter-code 404 -random-agent -output $file_name-favicon.txt

echo "httpx Done & result in $file_name-favicon.txt"
