# frozen_string_literal: true

require 'pry'
require 'awesome_print'
require_relative '../lib/modules'
require_relative '../lib/scrap'
require_relative '../lib/regions_hash'

rgn = RegionsJhu.new
browser = Watir::Browser.new
scrap = ScrapJhu.new browser
puts "Examples on how to extract the information:\n "
puts '   us_data = scrap.extract rgn.us'
puts '   world_data = scrap.extract rgn.world'
puts '   scrap.extract rgn.country "Costa Rica"'
puts '   scrap.extract rgn.state "Washington"'
puts "\nto retrieve the last query (New York is preloaded) type"
puts "   scrap.result\n"
puts "\nAwesome Print was added to facilitate viewing"
puts '   ap scrap.result'
puts 'or'
puts '   ap scrap.extract rgn.country "Spain"'
puts "\nCurrently ap does not support pagination\n\n"
puts "To quit type:\n"
puts "   exit\n\n"

scrap.extract rgn.state 'New York'

pry
