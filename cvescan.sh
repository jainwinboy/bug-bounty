domain=$1

# amass enum -passive -d $domain -o amass-domains.txt
# subfinder -dL seeds.txt | tee -a sf-domains.txt
# xargs -a seeds.txt -I@ sh -c 'assetfinder --subs-only @ | tee -a af-domains.txt'

cat *-domains.txt | anew domains.txt | httprobe --prefer-https -c 80 | anew hosts.txt
rm *-domains.txt

