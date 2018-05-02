#!/bin/bash
# Make functions.sh file accessible by this script:
. function_files/functions.sh

check_internet_connection response
echo -e '\n'
echo $response

prepare_files

download_file

# Execute ruby script to parse the HTML and create CSV files
ruby html_parser.ruby

# clean_output

number_mov=$(cat processed_files/parsed_output.csv | sed "1 d" | wc -l)


echo -e '\n'
echo "Movies playing in your area: $number_mov"
echo -e '\n'
cat processed_files/parsed_output.csv | awk '{gsub("Release:", ""); gsub("Runtime:", "");print}' | awk 'NR<2{print $0;next}{print $0 | "sort -b -r -t$'#' -k 2.1,2.4 -k 2.6,2.7 -k 2.9,2.10 -r"}' | column -ts $'\t'

# Remove the movies.txt file
# rm -rf scrape

