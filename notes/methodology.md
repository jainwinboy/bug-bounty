## setup

Sub Enum
========
mkdir ~/amass
cd amass
mkdir bin
mkdir scripts
<!-- copy all scripts from repo to /scripts and all needed binaries from ~/go/bin to /bin -->
amass enum -dir ~/amass -active -brute -src -d $domain

MASSDNS
=======
For json output:
massdns -c 25 -o J -r ~/downloads/massdns/lists/resolvers.txt -s 100 -w massdns.out -t A domains.txt
cat massdns.out | jq .name | sed 's/"//g' | sed 's/.$//g' | sort -u > massdns-domains.txt
cat massdns.out | jq '.data | .answers[]? | .data' | sed 's/"//g' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sort -u > massdns-ips.txt

For simple output:
massdns -c 25 -o S -r ~/downloads/massdns/lists/resolvers.txt -s 100 -w massdns.out -t A domains.txt
cat massdns.out | cut -d' ' -f1 | sed 's/.$//g' | sed 's/*.//g' | sort -u > massdns-domains.txt
cat massdns.out | grep -iv cname | cut -d' ' -f3 | sort -u > massdns-ips.txt
rm massdns.out

For preparing worldist:
======================
sub=$(echo $(pwd) | rev | cut -d'/' -f1 | rev);cat domains.txt | sed "s/$sub//g" | sed 's/*.//g' | tr '.' '\n' | sed '/^[[:space:]]*$/d' | sort -u > wordlist.txt;echo $sub | tr '.' '\n' | sed '/^[[:space:]]*$/d' >> wordlist.txt

Httpx
=====
cat massdns-domains.txt | httpx -silent -sc -title | tee httpx-hosts.txt
cat httpx-hosts.txt | grep 200 | cut -d' ' -f1 | tee hosts-200.txt
cat httpx-hosts.txt | grep 404 | cut -d' ' -f1 | tee hosts-404.txt
cat httpx-hosts.txt | grep 301 | cut -d' ' -f1 | tee hosts-301.txt
cat httpx-hosts.txt | grep 403 | cut -d' ' -f1 | tee hosts-403.txt
cat httpx-hosts.txt | grep 302 | cut -d' ' -f1 | tee hosts-302.txt

FUZZING
=======
ffuf -w ~/tools/dirsearch/db/dicc.txt -u FUZZ -mc all -ac
ffuf -w ./hosts.txt:DOMAIN -w ./wordlist.txt:PATH -u DOMAIN/PATH -c -mc 200
ffuf -w ./hosts.txt:DOMAIN -w ~/tools/dirsearch/db/dicc.txt:PATH -u DOMAIN/PATH -c -mc 200



nmap --open -p80,443,4080,4443 -iL massdns-domains.txt --script http-headers -oA nmap.out
