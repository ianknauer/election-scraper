require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'

doc = Nokogiri::HTML(open('http://coalitionavenirquebec.org/la-coalition/candidats'))

@p = doc.xpath('//section[@class="candidate"]/a')
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
  @party = "Coalition Avenir Québec"
  page = Nokogiri::HTML(open("#{person}"))
  @split = page.title.split(" » ")[0]
  @split2 = @split.split("  ")[1]
  @region = page.xpath('//div[@class="member-circonscription"]').text
  @links = page.css('a.member-email').map {|link| link['href'] } || ":Missing Email"
  @linksors = @links[0]
  @contact = @linksors.split(":")[1]
  puts @party
  puts @split2
  puts @contact
  puts @region
  @wrapped << [@party, @split2, @contact, @region]
end

CSV.open("CAV.csv", "wb") do |csv|
  i = 0
  @wrapped.each do
    csv << ["#{@wrapped[i][0]}", "#{@wrapped[i][1]}", "#{@wrapped[i][2]}", "#{@wrapped[i][3]}"]
    i += 1
  end
end












