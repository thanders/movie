#!/bin/bash

if nc -zw1 google.com 443; then
	echo "Internet connection works over HTTPS (port 443)"
	./process_movies.sh
elif nc -zw1 google.com 80; then
	echo "Internet connection works over HTTP (port 80)"
	./process_movies.sh
else
	echo "Internet connection isn't working over HTTP or HTTPS (ports 80 or 443)"
fi

if [[ -e movies.txt ]]; then
	wc=`wc -l < movies.txt`
	echo "$wc movies are playing in your area."
	echo -e '\n'
	column -ts $'\t' movies.txt
fi

# Remove the movies.txt file
rm movies.txt
