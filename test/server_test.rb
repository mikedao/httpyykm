require './test/test_helper'
require 'faraday'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/server.rb'

class ServerTest < Minitest::Test
  def test_it_can_respond_to_get_requests
    response = Faraday.get 'http://127.0.0.1:9292'

    assert_equal :get, response.env.method
    assert_equal "http://127.0.0.1:9292", response.env.url.to_s
  end

  def test_it_can_respond_to_post_requests
    response = Faraday.post 'http://127.0.0.1:9292/hello'

    assert_equal :post, response.env.method
  end

  def test_it_can_respond_to_root_path
    response = Faraday.get 'http://127.0.0.1:9292/'

    assert_equal "<pre>\n    Verb: GET\n    Path: /\n    Host: Faraday\n    Port: \n    Origin: Faraday\n    Accept: */*\n    </pre>", response.env.body
  end

  def test_it_can_respond_to_hello_path
    response = Faraday.get 'http://127.0.0.1:9292/hello'

    assert response.env.body.include?("Hello, World (")
  end

  def test_it_can_respond_to_datetime_path
    response = Faraday.get 'http://127.0.0.1:9292/datetime'

    assert_equal Time.now.strftime("%l:%M%p on %A, %B %e, %Y"), response.env.body
  end

  def test_it_can_respond_to_word_search_path
    conn = Faraday.new 'http://127.0.0.1:9292'
    response1 = conn.get '/word_search', { :word => 'portmanteau' }
    response2 = conn.get '/word_search', { :word => 'yoda' }

    assert_equal "portmanteau is a known word.", response1.env.body
    assert_equal "yoda is not a known word.", response2.env.body
  end

  def test_it_can_respond_to_start_game_path
    response = Faraday.get 'http://127.0.0.1:9292/start_game'

    assert_equal "Good luck!", response.env.body
  end

  def test_it_can_respond_to_get_game
    response = Faraday.get 'http://127.0.0.1:9292/game'

    assert response.env.body.include?("You have made")
  end

  def test_it_can_respond_to_invalid_post_game
    Faraday.get 'http://127.0.0.1:9292/start_game'
    conn = Faraday.new(:url => 'http://127.0.0.1:9292')
    response = conn.post '/game', { :number => "horse" }

    assert_equal 500, response.env.status
  end

  def test_it_can_respond_to_invalid_path
    response = Faraday.get 'http://127.0.0.1:9292/jibber_jabber'

    assert_equal 404, response.env.status
  end
end
