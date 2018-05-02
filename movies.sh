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
today=$(date)
echo "Movie data as of: $today"
echo "Movies playing in your area: $number_mov"
echo -e '\n'
# The sort below sorts by column k and then the number of digits until next k. The date string has 12 characters including an initial blank
cat processed_files/parsed_output.csv | awk '{gsub("Release:", ""); gsub("Runtime:", ""); gsub(" minutes", "");print}' | awk 'NR<2{print $0;next}{print $0 | "sort -b -t '\t' -k 1.9,1.12nr  -k 1.5,1.7Mr -k 1.1,1.3nr"}' | column -ts $'\t'

# Remove the movies.txt file
# rm -rf scrape

