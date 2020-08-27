# frozen_string_literal: true

require 'pry'
require_relative '../lib/modules'
require_relative '../lib/scrap'
require_relative '../lib/regions_hash'

rgn = RegionsJhu.new
browser = Watir::Browser.new
scrap = ScrapJhu.new browser

puts "Examples on how to extract the information:\n "
puts '   us_data = scrap.extract.(rgn.us)'
puts '   world_data = scrap.extract.(rgn.world)'
puts '   scrap.extract(rgn.country("Costa Rica"))'
puts '   scrap.extract(rgn.state("Washington"))'
puts "\nto retrieve the last query type"
puts "   scrap.result\n"
puts "\nexit to quit\n"

# scrap.extract(rgn.state('New York'))

pry
