## methodology

1. We start by collecting all seed domains like google.com and put them in one file called *roots.txt* or just clone [bounty-targets-data](https://github.com/arkadiyt/bounty-targets-data) and take out all the seed domains from there.

2. Put the *roots.txt* file through amass, subfinder, crtsh etc....

        xargs -a roots.txt -I@ bash -c 'amass enum --passive -d @ | tee -a domains.txt'
        xargs -a roots.txt -I@ bash -c 'subfinder -d @ | tee -a domains.txt'
        .
        .
        .

3. Put domains.txt through httprobe
        
        cat domains.txt | httprobe --prefer-https -c 50 | tee hosts.txt

4. Use nuclei to find cves
