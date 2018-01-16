#!/bin/bash

# Checks for connection to google.com from local port 443
if nc -zw1 google.com 443; then
	echo "Internet connection works over HTTPS (port 443)"
	./process_movies.sh
# Checks for connection to google.com from local port 80
elif nc -zw1 google.com 80; then
	echo "Internet connection works over HTTP (port 80)"
	./process_movies.sh
else
	echo "Internet connection isn't working over HTTP or HTTPS (ports 80 or 443)"
fi

# If movies.txt exists:
if [[ -e scrape/movies.txt ]]; then
	#Line count:
	wc=`wc -l < scrape/movies.txt`
	echo $wc " movies are playing in your area."
	#New line
	echo -e '\n'
	cat scrape/movies.txt | sort -b -r -t$'#' -k 2.1,2.4 -k 2.6,2.7 -k 2.9,2.10 | column -ts $'#'
fi

# Remove the movies.txt file
rm -rf scrape

