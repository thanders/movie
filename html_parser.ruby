#!/usr/bin/ruby

require 'nokogiri'
require 'xpath'
require 'csv'

page = Nokogiri::HTML(open("processed_files/data.html"))
page.xpath('//@style').remove


# Useful commands:
# puts page.css('.title').size
# puts page.css('.title').text

CSV.open("processed_files/parsed_output.csv", "wb", {:col_sep => "\t"}) do |csv|
csv << ['Release Date', 'Title', 'Genre', 'User Rating', 'Runtime (mins)']
page.css('#release_date').zip(page.css('.title'), page.css('.genre'), page.css('#user_rating'), page.css('#runtime')).each do |release_date, title, genre, user_rating, runtime|
  # csv << [title.text.gsub(/[[:space:]]/, '')]
  csv << [release_date.text.strip, title.text.strip, genre.text.gsub(/[[:space:]]/, '').strip, user_rating.text.gsub(/[[:space:]]/, '').strip, runtime.text.strip]
  end
end