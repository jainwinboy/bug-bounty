#!/bin/bash

domain=$1

subfinder -silent -d $domain | tee -a sf-domains.txt

echo subfinder ran first, total is $(cat sf-domains.txt | wc -l)

amass enum -passive -d $domain -o am-domains.txt
diff=$(cat am-domains.txt | anew sf-domains.txt | wc -l)
echo amass found $diff new subs

echo total is $(cat sf-domains.txt | wc -l)

assetfinder --subs-only $domain | tee -a af-domains.txt
diff=$(cat af-domains.txt | anew sf-domains.txt | wc -l)
echo assetfinder found $diff new subs

echo total is $(cat sf-domains.txt | wc -l)

# add github subdomain enum

# get info on chaos

mv sf-domains.txt domains.txt

# cat domains.txt | dnsgen - | massdns -r /path/to/resolvers.txt -t A -o J --flush 2>/dev/null
# parse subs from massdns.out into md-domains.txt
# diff=$(cat md-domains.txt | anew domains.txt | wc -l)
# echo dnsgen found $diff subs

# cat domains.txt | httprobe --prefer-https -c 80 | anew hosts.txt
rm *-domains.txt

