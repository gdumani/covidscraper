require 'open-uri'
require 'nokogiri'
require 'watir'

def load_html(site,link)
  page = open(site + link)
  Nokogiri::HTML(page)
end

def name_link(reg)
  name=reg.css('span').to_s.gsub(/<[^>]+>/,'')
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

browser=Watir::Browser.new
usdata=Hash.new
us.each do |k,v|
  browser.goto uri+v
  data=((Nokogiri::HTML(browser.html)).css('div.RegionOverview_overviewBlock__32xzs')).to_a 
  clean=Hash.new
  data.each {|d| clean.merge!({d.css('h3').to_s.gsub(/<[^>]+>/,'').chop => d.css('span').to_s.gsub(/<[^>]+>/,'')})} 
  usdata.merge!({k=>[{'Page link'=>v}.merge!(clean)]})
end

puts us
puts world
