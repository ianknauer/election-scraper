require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'

doc = Nokogiri::HTML(open('http://pq.org/candidats/'))

@p = doc.xpath('//table[@id="myTable"]/tbody/tr/td/a')
@urls = @p.map { |link| link['href'] }

@wrapped = Array.new

@candidates = []

for electorate in @urls 
  if electorate.include?("candidat/")
    @candidates << electorate
  else
  end
end

@candidates.uniq!

progress = 1
for person in @candidates
  @party = "PARTI QUÉBÉCOIS"
  page = Nokogiri::HTML(open("http://pq.org#{person}"))
  @name = page.xpath('//div[@class="deputedetails"]/div/h3').text
  @titles = page.xpath('//div[@class="deputedetails"]/div/h4').text
  @region = @titles.split(" dans ")[1]
  @links = page.css('table a').map {|link| link['href'] }
  @contact = Array.new
  @linksors = @links[0] || ['nil']
  if @linksors.include?('@') || @linksors == nil
    @contact = @linksors
  else
    @contact = ":missing Email"
  end
  @contact = @contact.split(":")[1]
  @wrapped << [@party.strip, @name.strip, @contact.strip, @region.strip]
  puts progress
  progress += 1
end

CSV.open("PQ.csv", "wb") do |csv|
  i = 0
  @wrapped.each do
    csv << ["#{@wrapped[i][0]}", "#{@wrapped[i][1]}", "#{@wrapped[i][2]}", "#{@wrapped[i][3]}"]
    i += 1
  end
end