#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-dns-Brute.sh <Domain(example.com)> <SubdomainList(example.com.resolve.txt)>"
    exit
fi


cat << EOF

     _     _          _                            ______ 
    (_)   (_)        | |     _                    (_____ \\
    ______ _____  ___| |__ _| |_ _____  ____ _____ _____) )_____  ____ ___  ____
   | ___  (____ |/___|  _ (_   _(____ |/ _  (_____|  __  /| ___ |/ ___/ _ \|  _ \\
  | |   | / ___ |___ | | | || |_/ ___ ( (_| |     | |  \ \| ____( (__| |_| | | | |
  |_|   |_\_____(___/|_| |_| \__\_____|\___ |     |_|   |_|_____)\____\___/|_| |_|
                                      (_____|         
                                                          Hashtag_AMIN
                                                  https://github.com/hashtag-amin
                                                  
EOF

echo "Run shuffledns & Brute force with heavy wordlist on: $1"
shuffledns -d $1 -r ../../wordlist/dns-resolvers.txt -w ../../wordlist/all-subdomain.txt -silent -o $1.dnsBrute.txt -mode bruteforce
echo "shuffledns Done & result in $1.dnsBrute.txt ==> len: ` cat $1.dnsBrute.txt | wc -l `"

echo "Run shuffledns & Brute force with 4 character wordlist on: $1"
shuffledns -d $1 -r ../../wordlist/dns-resolvers.txt -w ../../wordlist/4wordlist.txt -silent -o $1.dnsBrute.4word.txt -mode bruteforce
echo "shuffledns Done & result in $1.dnsBrute.4word.txt ==> len: ` cat $1.dnsBrute.4word.txt | wc -l `"
cat $1.dnsBrute.txt $1.dnsBrute.4word.txt | sort -u > $1.dnsBrute.Merg.txt

echo "Run dnsgen on: $1"
cat $2 $1.dnsBrute.Merg.txt | sort -u | dnsgen -w ../../wordlist/all-subdomain.txt - > $1.dnsgen.txt
echo "dnsgen Done & result in $1.dnsgen.txt ==> len: ` cat $1.dnsgen.txt | wc -l `"

echo "Run shuffledns & Resolving on: $1.dnsgen.txt"
shuffledns -l $1.dnsgen.txt -r ../../wordlist/dns-resolvers.txt -silent -o $1.dnsBrute-gen.txt -mode bruteforce
echo "shuffledns Done & result in $1.dnsBrute-gen.txt ==> len: ` cat $1.dnsBrute-gen.txt | wc -l `"

echo
echo "All Resolving Subdomain in $1.dnsBrute-gen.txt $1.dnsBrute.txt ==> len: ` cat $1.dnsBrute-gen.txt $1.dnsBrute.txt | wc -l `"
echo

