#!/bin/bash

domain=$1

# subfinder sub enum
subfinder -silent -d $domain | tee -a sf-domains.txt
echo subfinder ran first, total is $(cat sf-domains.txt | wc -l)

# amass sub enum
amass enum -passive -d $domain -o am-domains.txt
diff=$(cat am-domains.txt | anew sf-domains.txt | wc -l)
echo amass found $diff new subs
echo total is $(cat sf-domains.txt | wc -l)

#assetfinder sub enum
assetfinder --subs-only $domain | tee -a af-domains.txt
diff=$(cat af-domains.txt | anew sf-domains.txt | wc -l)
echo assetfinder found $diff new subs
echo total is $(cat sf-domains.txt | wc -l)

# github subdomain enum
github-subdomains -t 43a78b47c1614b4914a0f7a2a18b9f53c76d9136 -o gh-domains.txt -d $domain
diff=$(cat gh-domains.txt | grep $domain | anew sf-domains.txt | wc -l)
echo github subdomains found $diff new subs
echo total is $(cat sf-domains.txt | wc -l)

# shodan sub enum
~/tools/shosubgo/shosubgo_linux -d $domain -s eVRUxTWkYgR3WqKe30Ct8WyvEsRmk0PY > sg-domains.txt
diff=$(cat sg-domains.txt | anew sf-domains.txt | wc -l)
echo shosubgo found $diff new subs
echo total is $(cat sf-domains.txt | wc -l)

# cat domains.txt | dnsgen - | massdns -r /path/to/resolvers.txt -t A -o J --flush 2>/dev/null
# parse subs from massdns.out into md-domains.txt
# diff=$(cat md-domains.txt | anew domains.txt | wc -l)
# echo dnsgen found $diff subs

mv sf-domains.txt domains.txt
rm *-domains.txt

