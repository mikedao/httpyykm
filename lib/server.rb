require 'socket'
require './lib/parse_request'
require './lib/response'
require './lib/headers'

class Server
  def initialize
    @tcp_server     = TCPServer.new(9292)
    @output         = ""
    @headers        = ""
    @response       = Response.new
    @parsed_request = ""
    @post_content   = ""
  end

  def accept_request
    listener = @tcp_server.accept
    compile_request_lines(listener)
  end

  def compile_request_lines(listener)
    request_lines = []
      while line = listener.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
    @parsed_request = ParseRequest.new(request_lines)
    @post_content = listener.read(@parsed_request.content_length)
    return_response(@parsed_request, listener)
  end

  def game_input(post_content = @post_content)
    return post_content.split[-2]
  end

  def return_response(parsed_request, listener)
    if parsed_request.path == "/"
      @output = @response.root(parsed_request)
    elsif parsed_request.path == "/hello"
      @output = @response.hello
    elsif parsed_request.path == "/datetime"
      @output = @response.datetime
    elsif parsed_request.path.include?("/word_search")
      @output = @response.word_search(parsed_request.path)
    elsif parsed_request.verb == "GET" and parsed_request.path == "/start_game"
      @output = @response.get_start_game
    elsif parsed_request.verb == "POST" and parsed_request.path == "/start_game"
      @output = @response.post_start_game
    elsif parsed_request.verb == "GET" and parsed_request.path == "/game"
      @output = @response.get_game
    elsif parsed_request.verb == "POST" and parsed_request.path == "/game"
      @output = @response.post_game(game_input)
    elsif parsed_request.path == "/shutdown"
      @output = @response.shutdown
      build_headers(parsed_request.verb, parsed_request.path)
      response_view(listener)
      close(listener)
    else
      @output = @response.path_not_found
    end
    build_headers(parsed_request.verb, parsed_request.path)
    response_view(listener)
    accept_request
  end

  def response_view(listener, output = @output, headers = @headers)
    listener.puts headers
    listener.puts output
  end

  def close(listener)
    listener.close
  end

  def build_headers(verb, path, output = @output, response = @response)
    @headers = Headers.new(verb, path, output, response)
    @headers = @headers.build
  end
end
