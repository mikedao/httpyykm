require './test/test_helper'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/word_search'

class WordSearchTest < Minitest::Test
  def test_it_exists
    search = WordSearch.new

    assert_instance_of WordSearch, search
  end

  def test_result_searches_for_words
    search = WordSearch.new

    assert_equal "portmanteau is a known word.", search.result('portmanteau')
    assert_equal "yoda is not a known word.", search.result('yoda')
  end
end
