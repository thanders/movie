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

function prepare_files {

        # If download folder already exists:
        if [[ -e processed_files/ ]]; then
                # Removes files in the download folder - if empty error output is sent to /dev/null
                rm processed_files/* 2>>/dev/null
                rmdir processed_files/
        fi
        # Create the download folder
        mkdir processed_files
}

function download_file {
        # Download updated file
        wget -qO processed_files/data.html www.imdb.com/showtimes/location?ref_=sh_lc
}


# function clean_output {
#        for i in out.csv do
#        sed -n '()' > test.txt
#        # sed -n '(["'])(\\?.)*?\1''
#        # | tr ',' '-'
#}




