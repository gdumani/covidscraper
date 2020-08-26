require 'nokogiri'
require 'watir'
require_relative './modules'

class ScrapJhu
  include Filters
  attr_reader :result
  def initialize(browser)
    @uri = 'http://coronavirus.jhu.edu'
    @buttons = ['All Time', 'Past Day', 'Past Week', 'Past Month']
    @separator_region = 'div.RegionMenu_items__3D_d2'
    @separator_item = 'div.RegionOverview_overviewBlock__32xzs'
    @item_class = 'RegionOverview_statValue__xtlKt'
    @browser=browser
    @result={} 
  end


  def extract(region)
    res={}
    region.each do |k, v|
      @browser.goto @uri + v
      @browser.wait_until { |b| b.span(class: @item_class).text != 'Loading...' }
      resbtn = {}
      @buttons.each do |btn|
        @browser.button(text: btn).click
        data = Nokogiri::HTML(@browser.html).css(@separator_item).to_a
        clean = {}
        data.each do |d|
          d_value = d.css('span').map { |x| untag(x) }
          clean.merge!({ untag(d.css('h3')).chop => d_value })
        end
        resbtn.merge!({ btn => clean })
      end
      res.merge!({ k => resbtn })
    end
    @result=res
  end
end
