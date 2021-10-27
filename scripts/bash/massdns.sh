massdns -c 25 -o S -r ~/downloads/massdns/lists/resolvers.txt -s 100 -w massdns.out -t A domains.txt
cat massdns.out | cut -d' ' -f1 | sed 's/.$//g' | sed 's/*.//g' | sort -u > massdns-domains.txt
cat massdns.out | grep -iv cname | cut -d' ' -f3 | sort -u > massdns-ips.txt
rm massdns.out