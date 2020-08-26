# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require_relative './modules'

# Tool to extract links required to fetch covid data form coronavirus.jhu.edu
class RegionsJhu
  include Filters
  attr_reader :us, :world
  def initialize
    separator_region = 'div.RegionMenu_items__3D_d2'
    uri = 'http://coronavirus.jhu.edu'
    link = '/region'
    regions = load_html(uri, link).css(separator_region)
    @us = links_hash(regions[0])
    @world = links_hash(regions[1])
  end

  def country(var)
    @world.select { |k, _v| k == var }
  end

  def state(var)
    @us.select { |k, _v| k == var }
  end

  private

  def load_html(site, link)
    page = URI.open(site + link)
    Nokogiri::HTML(page)
  end

  def extract_link(reg)
    name = untag(reg.css('span'))
    ref = reg.map.to_h['href']
    { name => ref }
  end

  def links_hash(reg)
    res = {}
    reg.css('a').each { |r| res.merge!(extract_link(r)) }
    res
  end
end
