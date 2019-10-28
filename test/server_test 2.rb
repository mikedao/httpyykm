require 'pry'
require 'socket'
require 'net/http'
require 'faraday'
require_relative '../lib/server'
require "Minitest/autorun"
require "Minitest/pride"

class ServerTest < MiniTest::Test

  def test_server_can_connect
    response = Faraday.get('http://localhost:9292/')
    assert_equal 200, response.status
  end

  # def test_server_can_receive_request_lines
  #   response = Faraday.get('http://localhost:9292/')
  #   assert_equal "GET", response.verb
  #
  # end

end
