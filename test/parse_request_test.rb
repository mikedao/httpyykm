require './test/test_helper'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/parse_request'

class ParseRequestTest < Minitest::Test
  def test_it_exists
    parsed_request = ParseRequest.new(["POST /game HTTP/1.1",
                                       "Host: 127.0.0.1:9292",
                                       "Connection: keep-alive",
                                       "Content-Length: 139",
                                       "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
                                       "Cache-Control: no-cache",
                                       "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
                                       "Postman-Token: bc192ae9-011e-4445-e20c-044807677dc7",
                                       "Content-Type: text/plain",
                                       "Accept: */*",
                                       "Accept-Encoding: gzip, deflate, br",
                                       "Accept-Language: en-US,en;q=0.9"])

  assert_instance_of ParseRequest, parsed_request
  end

  def test_diagnostics_returns_correct_information
    parsed_request = ParseRequest.new(["POST /game HTTP/1.1",
                                       "Host: 127.0.0.1:9292",
                                       "Connection: keep-alive",
                                       "Content-Length: 139",
                                       "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
                                       "Cache-Control: no-cache",
                                       "Postman-Token: bc192ae9-011e-4445-e20c-044807677dc7",
                                       "Content-Type: text/plain",
                                       "Accept: */*",
                                       "Accept-Encoding: gzip, deflate, br",
                                       "Accept-Language: en-US,en;q=0.9"])

  return_value = parsed_request.diagnostics
  expected = "<pre>
    Verb: POST
    Path: /game
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: */*
    </pre>"

  assert_equal expected, return_value
  end
end
