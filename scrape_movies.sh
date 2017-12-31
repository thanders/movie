mkdir scrape
# Download updated file
wget -qO scrape/data.html www.imdb.com/showtimes/location?ref_=sh_lc
sed -i 's/hidden inline-sort-params/dingle/g' scrape/data.html
hxnormalize -ex scrape/data.html | hxselect -s '\n' 'div.dingle' >> scrape/output.html
# Define the internal field separator as a new line
IFS=$'\n'
# Parse each group by searching for each variable and cutting the data
for line in $(cat scrape/output.html); do
	title=`echo -n $line | grep 'alpha' | cut -d '"' -f 8,8`
	release_date=`echo -n $line | grep 'release_date' | cut -d '"' -f 16,16`
	echo -e $title '\t' $release_date >> scrape/parsed.txt
done
# Remove spaces and create movies.txt
egrep -v "^[[:space:]]*$|^#" scrape/parsed.txt >> movies.txt

rm -rf scrape
