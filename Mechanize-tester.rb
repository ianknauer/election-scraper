require 'rubygems'
require 'mechanize'

agent = Mechanize.new

page = agent.get('http://plq.org/en/team')

@politicians = agent.page.search(:class => "result")

puts @politicians.first.to_s
