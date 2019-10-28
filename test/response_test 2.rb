require "Minitest/autorun"
require "Minitest/pride"
require_relative "../lib/response"

class ResponseTest < MiniTest::Test
  def setup

  end

  def test_it_exists
    response = Response.new("Hello World")
    assert_instance_of Response, response
  end

  def test_it_initializes_with_body
    response = Response.new("Hello World")
    assert_equal "Hello World", response.body
  end

  def test_it_has_output
    response = Response.new("Hello World")
    expected = "<html><head></head><body>Hello World</body></html>"
    assert_equal expected, response.output
  end

  def test_response_has_header
    response = Response.new("Hello World")
    expected = "http/1.1 200 ok"
    actual = response.header.split("\r\n")[0]
    assert_equal expected, actual
  end

  def test_it_responds_with_header_and_body
    response = Response.new("Hello World")
    assert_equal [response.header, response.output], response.respond_with_header
  end

  def test_it_reports_response
    response = Response.new("Hello World")
    expected = "Header:\n\r#{response.header}\r\nResponse:#{response.output}"
    actual = response.report_response
    assert_equal expected, actual
  end
end
