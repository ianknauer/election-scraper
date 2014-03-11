require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

politicians = Array.new

doc = Nokogiri::HTML(open("http://www.plq.org/en/team"))

@politicians = doc.xpath("//div/h3/a").collect {|node| node.text.strip}



number = 0

for item in @politicians 

  puts item + " " + number.to_s
  number += 1
end

#Put all this shit in a csv
#CSV.open("file.csv", "wb") do |csv|
#  csv << ["item"]
#  until @items.empty?
#    csv << [@items.shift]
#  end
#end