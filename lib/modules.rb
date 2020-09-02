# frozen_string_literal: true

# Module to clean html tags form a string
module Filters
  def untag(tagged)
    tagged.to_s.gsub(/<[^>]+>/, '')
  end
end
