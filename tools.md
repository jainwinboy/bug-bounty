## methodology

1. Install golang v1.17.2

        mkdir ~/downloads
        cd ~/downloads
        wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz

    Just add the following lines to ~/.profile and this will persist.

        export GOPATH=$HOME/go
        export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

2. Install golang tools

        go install github.com/tomnomnom/anew@latest
        go install github.com/tomnomnom/assetfinder@latest
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
