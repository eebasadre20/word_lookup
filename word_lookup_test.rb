require 'minitest/autorun'
require_relative 'word_lookup'

class WordLookupTest < Minitest::Test
  def test_return_total_points
    word_lookup = WordLookup.new('word_lookup_sample.txt', 'Disco')

    assert word_lookup.total_points == 82
  end
end