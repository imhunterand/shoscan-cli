#!/usr/bin/env bash

mycmd=$(ls ~/.shodan/api_key &>/dev/null)
if [[ $mycmd -ne 0 ]]; then
    echo "This script will take care of installing shodan cli and and initiating it"
    echo ""
    echo "Create an account in shodan.io"
    echo ""
    echo "get the API KEY"
    echo ""
    echo "installing shodan API..."
    pip3 install shodan #will install shodan API using pip
    echo ""
    sleep 1
    echo "Paste your shodan API KEY"
    read -rp "here : " AK
    shodan init "$AK" #initiating shodan api
    echo "It is all set up.!!"
else
    echo "You are good to go!!"
fi
