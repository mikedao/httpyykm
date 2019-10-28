require './test/test_helper'
require 'faraday'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_begins_with_correct_attributes
    game = Game.new

    assert_equal 0, game.current_guess
    assert_equal 0, game.guess_count
  end

  def test_it_counts_guesses
    game = Game.new

    game.make_guess("50")
    game.make_guess("75")
    game.make_guess("80")

    assert_equal 3, game.guess_count
  end

  def test_make_guess_accepts_guesses
    game = Game.new

    game.make_guess("50")

    assert_equal 50, game.current_guess

    game.make_guess("75")
    game.make_guess("80")

    assert_equal 80, game.current_guess
  end

  def test_guess_evaluation_returns_string
    game = Game.new

    game.make_guess("50")
    game.make_guess("75")
    game.make_guess("80")
    evaluation = game.guess_evaluation

    assert_instance_of String, evaluation
  end

  def test_game_info_returns_count_and_evaluation
    game = Game.new

    game.make_guess("50")
    game.make_guess("75")
    game.make_guess("80")
    info = game.game_info

    assert_instance_of String, info
    assert info.include?(game.guess_count.to_s)
  end

  def test_faraday_can_start_game
    response = Faraday.get 'http://127.0.0.1:9292/start_game'

    assert_equal "Good luck!", response.env.body
  end
end
