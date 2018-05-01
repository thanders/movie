#!/bin/bash

function check_internet_connection() {

    local  __response=$1

        # Checks for connection to google.com from local port 443
        if nc -zw1 google.com 443; then
        local  myresult='Internet connection works over HTTPS (port 443)'
        eval $__response="'$myresult'"
                #./process_movies.sh

        # Checks for connection to google.com from local port 80
        elif nc -zw1 google.com 80; then
        local  myresult='Internet connection works over HTTP (port 80)'
        eval $__resultvar="'$myresult'"
        else
        local  myresult='Internet connection not working over HTTPS or HTTP (ports 443 or 80)'
        eval $__resultvar="'$myresult'"
        fi

}

function prepare_download {

        # If download folder already exists:
        if [[ -e download/ ]]; then
                rm /download/ *
                # rm download/
        fi
        # Create the download folder
        mkdir download
}