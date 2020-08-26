require 'open-uri'
require 'nokogiri'
require 'watir'
require 'pry'
require_relative '../lib/modules'
require_relative '../lib/scrap'

def load_html(site, link)
  page = open(site + link)
  Nokogiri::HTML(page)
end

def extract_link(reg)
  name = untag(reg.css('span'))
  ref = reg.map.to_h['href']
  { name => ref }
end

include Filters

separator_region = 'div.RegionMenu_items__3D_d2'
uri = 'http://coronavirus.jhu.edu'
link = '/region'

regions = load_html(uri, link).css(separator_region)

us_links = {}
regions[0].css('a').each { |r| us_links.merge!(extract_link(r)) }

world_links = {}
regions[1].css('a').each { |r| world_links.merge!(extract_link(r)) }

browser = Watir::Browser.new
scrap=ScrapJhu.new browser

# us_data = scrap.extract.(us_links)
# world_data = scrap.extract.(world_links)


pry
