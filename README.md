
## methodology

1. We start by collecting all seed domains like google.com and put them in one file called *roots.txt*.
2. Put the *roots.txt* file through amass and subfinder

        xargs -a roots.txt -I@ bash -c 'amass enum --passive -d @ | tee -a domains'
        xargs -a roots.txt -I@ bash -c 'subfinder -d @ | tee -a domains'

