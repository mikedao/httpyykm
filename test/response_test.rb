require './test/test_helper'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/response'

class ResponseTest < Minitest::Test
  def test_it_exists
    response = Response.new

    assert_instance_of Response, response
  end

  def test_increase_count_increases_the_count
    response = Response.new

    response.increase_count
    response.increase_count

    assert_equal 2, response.count
  end

  def test_root_returns_diagnostics
    response = Response.new

    return_value = response.root(ParseRequest.new(["GET /start_game HTTP/1.1",
                                                   "Host: 127.0.0.1:9292",
                                                   "Connection: keep-alive",
                                                   "Cache-Control: no-cache",
                                                   "Content-Type: text/plain",
                                                   "User-Agent: Mozilla/5.0 (Macint...Safari/537.36",
                                                   "Postman-Token: 924241b4-f760-5091-af0f-2cc6236af464",
                                                   "Accept: */*",
                                                   "Accept-Encoding: gzip, deflate, br",
                                                   "Accept-Language: en-US,en;q=0.9"]))
    expected = "<pre>
    Verb: GET
    Path: /start_game
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: */*
    </pre>"

    assert_equal expected, return_value
  end

  def test_hello_increases_hello_count
    response = Response.new

    return_value = response.hello
    return_value = response.hello

    assert_equal 2, response.hello_count
  end

  def test_hello_returns_hello_world
    response = Response.new

    return_value = response.hello
    return_value = response.hello

    assert_equal "Hello, World (2)", return_value
  end

  def test_datetime_returns_current_datetime
    response = Response.new

    return_value = response.datetime

    assert_equal Time.now.strftime("%l:%M%p on %A, %B %e, %Y"), return_value
  end

  def test_shutdown_returns_total_request_count
    response = Response.new

    return_value = response.shutdown

    assert_equal "Total Requests: 1", return_value
  end

  def test_word_search_returns_word_search_result
    response = Response.new

    return_value1 = response.word_search("/word_search?word=portmanteau")
    return_value2 = response.word_search("/word_search?word=yoda")

    assert_equal "portmanteau is a known word.", return_value1
    assert_equal "yoda is not a known word.", return_value2
  end

  def test_get_start_game_starts_new_game
    response = Response.new

    return_value = response.get_start_game

    assert_instance_of Game, response.game
    assert_equal "Good luck!", return_value
  end

  def test_post_start_game_returns_403_error
    response = Response.new

    return_value = response.post_start_game

    refute_instance_of Game, response.game
    assert_equal "403 Forbidden. Game already in progress.", return_value
  end

  def test_get_game_returns_game_info
    response = Response.new
    response.get_start_game

    return_value = response.get_game

    assert_equal "You have made 0 guesses. 0 is less than the number.", return_value
  end

  def test_post_game_returns_guess_again
    response = Response.new
    response.get_start_game

    return_value = response.post_game("100")

    assert_equal "Guess again.", return_value
  end

  def test_path_not_found_returns_404
    response = Response.new
    response.path_not_found

    return_value = response.path_not_found

    assert_equal "404: Path not found.", return_value
  end
end
