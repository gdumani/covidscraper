require 'open-uri'
require 'nokogiri'
require 'byebug'

def load_html(site,link)
  page = open(site + link)
  Nokogiri::HTML(page)
end

uri='http://coronavirus.jhu.edu'
link="/region"
separator="div.RegionMenu_items__3D_d2"

regions= load_html(uri,link).css(separator)

puts regions.count