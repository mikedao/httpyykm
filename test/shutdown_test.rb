require './test/test_helper'
require 'faraday'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/server.rb'

class ServerTest < Minitest::Test
  def test_it_can_respond_to_shutdown_path
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'

    assert response.env.body.include?("Total Requests:")
  end
end
