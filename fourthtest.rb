require 'csv'

@politicians = Array.new

@party = "Parti libéral du Québec "
@name = "Chantal Tremblay "
@email = "Chantal.Tremblay@plq.org "
@region = "Iberville "

@party1 = "Parti libéral du Québec "
@name1 = "Chantal Tremblay "
@email1 = "Chantal.Tremblay@plq.org "
@region1 = "Iberville "

@politicians << [@party.strip, @name.strip, @email.strip, @region.strip]
@politicians << [@party1.strip, @name1.strip, @email1.strip, @region1.strip]

puts @politicians[0][2]

CSV.open("tester.csv", "wb") do |csv|
  i = 0
  @politicians.each do
    csv << ["#{@politicians[i][0]}", "#{@politicians[i][1]}", "#{@politicians[i][2]}", "#{@politicians[i][3]}"]
    i += 1
  end
end