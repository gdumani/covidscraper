module Filters
  def untag(tagged)
    tagged.to_s.gsub(/<[^>]+>/, '')
  end
end


