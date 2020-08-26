require 'pry'
require_relative '../lib/modules'
require_relative '../lib/scrap'
require_relative '../lib/regions_hash'


rgn = RegionsJhu.new

browser = Watir::Browser.new
scrap = ScrapJhu.new browser

# us_data = scrap.extract.(rgn.us)
# world_data = scrap.extract.(rgn.world)
# scrap.extract(rgn.country("Costa Rica"))
# scrap.extract(rgn.state("Washington"))
pry
