# frozen_string_literal: true

require 'watir'
require_relative '../lib/regions_hash'
require_relative '../lib/scrap'

describe RegionsJhu do
  let(:rgn) { RegionsJhu.new }
  let(:us_first_link) { ['Alabama', '/region/us/alabama'] }
  let(:world_first_link) { ['Afghanistan', '/region/afghanistan'] }

  describe '#initialize' do
    it 'rgn.us returns a hash of 52 parsed elements' do
      expect(rgn.us.count).to eql(52)
    end

    it 'rgn.world returns a hash of 186 parsed elements' do
      expect(rgn.world.count).to eql(186)
    end

    it 'rgn.us and rgn.world are hashes' do
      expect(rgn.us.class).to eql(Hash)
      expect(rgn.world.class).to eql(Hash)
    end

    it 'rgn.us and rgn.world return a key and a link' do
      expect(rgn.us.first).to eql(us_first_link)
      expect(rgn.world.first).to eql(world_first_link)
    end

    it 'rgn.us retrieves a US state but not a country' do
      expect(rgn.us['Colorado']).to eql('/region/us/colorado')
      expect(rgn.us['Colombia']).to eql(nil)
    end

    it 'rgn.world retrieves a country but not a state' do
      expect(rgn.world['Colorado']).to eql(nil)
      expect(rgn.world['Colombia']).to eql('/region/colombia')
    end
  end

  describe '#country' do
    it 'returns a country => link hash for a country but and empty hash for a state' do
      expect(rgn.country('Colorado')).to eql({})
      expect(rgn.country('Colombia')).to eql({ 'Colombia' => '/region/colombia' })
    end
  end

  describe '#state' do
    it 'returns a country => link hash for a country but and empty hash for a state' do
      expect(rgn.state('Colorado')).to eql({ 'Colorado' => '/region/us/colorado' })
      expect(rgn.state('Colombia')).to eql({})
    end
  end
end

describe ScrapJhu do
  let(:browser) { Watir::Browser.new }
  let(:scrap) { ScrapJhu.new(browser) }
  let(:test_hash) { { 'Benin' => '/region/benin', 'Chad' => '/region/chad' } }

  describe '#initialize' do
    it 'returns "Watir::Browser" when browser was successfully passed' do
      expect(scrap.browser_status).to eql('Watir::Browser')
    end

    it 'Initializes result with an empty hash' do
      expect(scrap.result).to eql({})
    end
  end

  describe '#extract' do
    it 'returns a hash with data of two countries' do
      expect(scrap.extract(test_hash).class).to eql(Hash)
      expect(scrap.result.count).to eql(2)
      expect(scrap.result['Chad'].class).to eql(Hash)
      expect(scrap.result['Chad'].count).to eql(4)
      expect(scrap.result['Chad']['All Time'].class).to eql(Hash)
      expect(scrap.result['Chad']['All Time'].count).to be >= 2
      expect(scrap.result['Chad']['All Time']['Deaths'].class).to eql(Array)
      expect(scrap.result['Chad']['All Time']['Deaths'][0].class).to eql(String)
    end
  end
end
