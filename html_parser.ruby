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
csv << ['Title', 'Release Date', 'Genre', 'User Rating', 'Runtime']
page.css('.title').zip(page.css('#release_date'), page.css('.genre'), page.css('#user_rating'), page.css('#runtime')).each do |title, release_date, genre, user_rating, runtime|
  # csv << [title.text.gsub(/[[:space:]]/, '')]
  csv << [title.text.gsub(/[[:space:]]/, '').strip, release_date.text.gsub(/[[:space:]]/, '').strip, genre.text.gsub(/[[:space:]]/, '').strip, user_rating.text.gsub(/[[:space:]]/, '').strip, runtime.text.gsub(/[[:space:]]/, '').strip]
  end
end