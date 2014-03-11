require 'rubygems'
require 'mechanize'
require 'csv'

agent = Mechanize.new
page = agent.get('http://plq.org/en/team')

@list = agent.page.links_with(:class => 'member')

@politicians = Array.new

for page in @list
  @individual = page.click
  @title = @individual.title
  @party = @title.split(":")[0]
  @secondsplit = @title.split(":")[1]
  @name = @secondsplit.split(" - ")[0]
  @region = @secondsplit.split(" - ")[1]

  @individual.links.each do |link|
    if /@plq.org/.match(link.to_s)
     @email = link.text
    else
    end
  end
  @politicians << [@party.strip, @name.strip, @email.strip, @region.strip] 
end

CSV.open("tester.csv", "wb") do |csv|
  i = 0
  @politicians.each do
    csv << ["#{@politicians[i][0]}", "#{@politicians[i][1]}", "#{@politicians[i][2]}", "#{@politicians[i][3]}"]
    i += 1
  end
end



