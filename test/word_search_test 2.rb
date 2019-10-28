require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/pages/word_search'
class WordSearchTest < MiniTest::Test
  include WordSearch
  def test_word_search_returns_known_words
    word = "example"
    expected = "example is a known word"
    assert_equal expected, word_search(word)
  end

  def test_word_search_returns_more_known_words
    word = "hello"
    expected = "hello is a known word"
    assert_equal expected, word_search(word)
  end

  def test_word_search_returns_downcase_known_words
    word = "HELP"
    expected = "help is a known word"
    assert_equal expected, word_search(word)
  end

  def test_word_search_returns_unknown_words
    word = "xdygh"
    expected = "xdygh is not a known word"
    assert_equal expected, word_search(word)
  end
end
