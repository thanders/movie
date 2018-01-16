#!/bin/bash
mkdir scrape
# Download updated file
wget -qO scrape/data.html www.imdb.com/showtimes/location?ref_=sh_lc
sed -i 's/hidden inline-sort-params/dingle/g' scrape/data.html
hxnormalize -ex scrape/data.html | hxselect -s '\n' 'div.dingle' | tr -s [:space:] ' ' | sed 's/<\/div>/\'$'\n/g' >> scrape/output.txt
# Define the internal field separator as a new line
IFS=$'\n'
# Parse each group by searching for each variable and cutting the data
# For each div dingle

title=()
release_date=()

for line in $(cat scrape/output.txt); do
	title+=("`echo $line | grep 'alpha' | cut -d '"' -f 8,8`")
	release_date+=("`echo $line | grep -C 1 'release_date' | cut -d '"' -f 16,16`")
done

n=${#title}

for ((i=0;i<$n;i++)); do
	echo "${title[$i]}"#"${release_date[$i]}" >> scrape/parsed.txt;
	
done

# Removes lines with 1 character (,) , adds / to dates, replaes // with nothing
awk 'length>1' scrape/parsed.txt | awk -F '#' '{ print $1 "#" substr($2,1,4)"/"substr($2,5,2)"/"substr($2,7,2) }' | sed 's|//||g' >> scrape/movies.txt
#tr -d "v" < scrape/parsed.txt

#rm -rf scrape
