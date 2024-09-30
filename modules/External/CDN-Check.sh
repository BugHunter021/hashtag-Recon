#!/bin/bash
if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash CDN-Check.sh Domain List file like (example.com.txt)>"
    exit
fi

RED='\033[0;31m'
NC='\033[0m' # No Color
file_name=` echo $1 |  sed "s/.txt//g" `
exec 3<> $file_name-CDN-check.txt

echo -e "if you want to Exit Press ${RED}Ctrl+z ${NC} for end checking"

while IFS= read -r line; do
  CheckResult=$(wappy -u "$line" | grep CDN 2>&1)
  if [ "$CheckResult" != "" ]; then
    echo -e "Checking -----> $line ${RED} $CheckResult${NC}";
    echo "$line" >&3
  else
      echo "Checking -----> $line" 
  fi
done < "$1"

exec 3>&-
echo "checking Done & result in $file_name-CDN-check.txt ==> len: ` cat $file_name-CDN-check.txt | wc -l `"
