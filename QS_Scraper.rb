require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'pry'

doc = Nokogiri::HTML(open('http://www.quebecsolidaire.net/equipe/'))

@p = doc.xpath('//div[@class="team-mate"]/a')
@urls = @p.map { |link| link['href'] }

@wrapped = Array.new

@candidates = []

for electorate in @urls 
  if electorate.include?("equipe/")
    @candidates << electorate
  else
  end
end

@candidates.uniq!

progress = 1
for person in @candidates
  @party = "Québec solidaire"
  @page = Nokogiri::HTML(open("#{person}"))
  @name = @page.title.split(" – ")[0]
  @region = @page.xpath('//h3[@class="pale sub-title"]/a').text
  @wrapped << [@party, @name, @region]
end

CSV.open("QS.csv", "wb") do |csv|
  i = 0
  @wrapped.each do
    csv << ["#{@wrapped[i][0]}", "#{@wrapped[i][1]}", "#{@wrapped[i][2]}"]
    i += 1
  end
end

