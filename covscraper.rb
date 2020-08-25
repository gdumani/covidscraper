require 'open-uri'
require 'nokogiri'
require 'watir'
require 'pry'

def load_html(site, link)
  page = open(site + link)
  Nokogiri::HTML(page)
end

def name_link(reg)
  name = untag(reg.css('span'))
  ref = reg.map.to_h['href']
  { name => ref }
end

def extract_pages(region, buttons, browser, uri, item_class, separator_item)
  result = {}
  region.each do |k, v|
    browser.goto uri + v
    browser.wait_until { |b| b.span(class: item_class).text != 'Loading...' }
    resbtn = {}
    buttons.each do |btn|
      browser.button(text: btn).click
      data = Nokogiri::HTML(browser.html).css(separator_item).to_a
      clean = {}
      data.each do |d|
        d_item = d.css('span').map { |item| untag(item) }
        clean.merge!({ untag(d.css('h3')).chop => d_item })
      end
      resbtn.merge!({ btn => clean })
    end
    result.merge!({ k => resbtn })
  end
  result
end

def untag(tagged)
  tagged.to_s.gsub(/<[^>]+>/, '')
end

uri = 'http://coronavirus.jhu.edu'
link = '/region'

buttons = ['All Time', 'Past Day', 'Past Week', 'Past Month']
separator_region = 'div.RegionMenu_items__3D_d2'
separator_item = 'div.RegionOverview_overviewBlock__32xzs'
item_class = 'RegionOverview_statValue__xtlKt'

regions = load_html(uri, link).css(separator_region)

us_links = {}
regions[0].css('a').each { |r| us_links.merge!(name_link(r)) }

world_links = {}
regions[1].css('a').each { |r| world_links.merge!(name_link(r)) }

browser = Watir::Browser.new
us = extract_pages(us_links, buttons, browser, uri, item_class, separator_item)
world = extract_pages(world_links, buttons, browser, uri, item_class, separator_item)
puts 'information is stored in Hashes "us" and "world". '
pry
