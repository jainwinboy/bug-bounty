## setup

1. Install golang v1.17.2

        mkdir ~/downloads
        cd ~/downloads
        wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz

    Just add the following lines to ~/.profile and this will persist.

        vi ~/.profile
        export GOPATH=$HOME/go
        export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
        source ~/.profile

2. Install tools for sub enum

        sudo snap install amass
        go install github.com/tomnomnom/assetfinder@latest
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        go install github.com/tomnomnom/anew@latest

3. Install massdns

        sudo apt install make
        sudo apt install gcc
        cd ~/downloads
        git clone https://github.com/blechschmidt/massdns.git
        cd massdns
        make


