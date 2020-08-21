require 'open-uri'
require 'nokogiri'
require 'byebug'

def load_html(site,link)
  page = open(site + link)
  Nokogiri::HTML(page)
end

def name_link(reg)
  name=reg.css('span').to_s.delete_prefix('<span>').delete_suffix('</span>')
  ref= reg.map.to_h['href']
  {name => ref}
end

uri='http://coronavirus.jhu.edu'
link="/region"
separator="div.RegionMenu_items__3D_d2"

regions= load_html(uri,link).css(separator)

us=Hash.new
regions[0].css('a').each {|r| us.merge!(name_link r)}

world=Hash.new
regions[1].css('a').each {|r| world.merge!(name_link r)}


puts us
puts world
