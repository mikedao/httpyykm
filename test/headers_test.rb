require './test/test_helper'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/headers'
require './lib/response'

class HeadersTest < Minitest::Test
  def test_it_exists
    headers = Headers.new("GET", "/", "diagnostics", Response.new)

    assert_instance_of Headers, headers
  end

  def test_default_headers_returns_array_of_correct_data
    headers = Headers.new("GET", "/", "diagnostics", Response.new)

    return_value = headers.default_headers

    assert_equal 4, return_value.count
    assert_equal "server: ruby", return_value[1]
  end

  def test_ok_returns_array_of_correct_data
    headers = Headers.new("GET", "/", "diagnostics", Response.new)

    return_value = headers.ok

    assert_equal 5, return_value.count
    assert_equal "http/1.1 200 ok", return_value[0]
  end

  def test_redirect_game_returns_array_of_correct_data
    headers = Headers.new("POST", "/game", "guess again.", Response.new)
    headers.response.get_start_game

    return_value = headers.redirect_game

    assert_equal "location: http://127.0.0.1:9292/game", return_value[1]
  end

  def test_redirect_start_game_returns_array_of_correct_data
    headers = Headers.new("POST", "/start_game", "good luck.", Response.new)

    return_value = headers.redirect_start_game

    assert_equal "location: http://127.0.0.1:9292/start_game", return_value[1]
  end

  def test_forbidden_returns_array_of_correct_data
    headers = Headers.new("POST", "/start_game", "good luck", Response.new)

    return_value = headers.forbidden

    assert_equal "http/1.1 403 Forbidden", return_value[0]
  end

  def test_not_found_returns_array_of_correct_data
    headers = Headers.new("POST", "/jibber_jabber", "", Response.new)

    return_value = headers.not_found

    assert_equal "http/1.1 404 Not Found", return_value[0]
  end

  def test_build_returns_not_found_headers
    headers = Headers.new("POST", "/jibber_jabber", "", Response.new)

    return_value = headers.build

    assert_equal "http/1.1 404 Not Found", return_value[0]
  end

  def test_build_returns_redirect_start_game_headers
    headers = Headers.new("POST", "/start_game", "Good Luck", Response.new)

    return_value = headers.build

    assert_equal "location: http://127.0.0.1:9292/start_game", return_value[1]
  end

  def test_build_returns_forbidden_start_game_headers
    headers = Headers.new("POST", "/start_game", "Good Luck", Response.new)
    headers.response.get_start_game

    return_value = headers.build

    assert_equal "http/1.1 403 Forbidden", return_value[0]
  end

  def test_build_returns_redirect_game_headers
    headers = Headers.new("POST", "/game", "game info", Response.new)
    headers.response.get_start_game

    return_value = headers.build

    assert_equal "location: http://127.0.0.1:9292/game", return_value[1]
  end

  def test_build_returns_ok_headers
    headers = Headers.new("GET", "/game", "game info", Response.new)

    return_value = headers.build

    assert_equal "http/1.1 200 ok", return_value[0]
  end
end
