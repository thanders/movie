#!/bin/bash
# Make functions.sh file accessible by this script:
. function_files/function.sh

check_internet_connection response
echo $response



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

