class Headers
  attr_reader :response

  def initialize(verb, path, output, response)
    @verb           = verb
    @path           = path
    @output_length  = output.length
    @response       = response
    @valid_paths    = ["/", "/hello", "/datetime", "/shutdown",
                      "/word_search", "/game", "/start_game"]
  end

  def default_headers
    ["date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{@output_length}\r\n\r\n"]
  end

  def ok
    default_headers.unshift("http/1.1 200 ok")
  end

  def redirect_game
    default_headers.unshift("http/1.1 301 Moved Permanently",
                            "location: http://127.0.0.1:9292/game")
  end

  def redirect_start_game
    default_headers.unshift("http/1.1 301 Moved Permanently",
                           "location: http://127.0.0.1:9292/start_game")
  end

  def forbidden
    default_headers.unshift("http/1.1 403 Forbidden")
  end

  def not_found
    default_headers.unshift("http/1.1 404 Not Found")
  end

  def force_error
    default_headers.unshift("http/1.1 500 SystemError")
  end

  def build
    if @verb == "GET" && @valid_paths.include?(@path)
      return ok
    elsif @verb == "POST" && @path == "/game"
      if @response.game.current_guess == "Invalid input"
        return force_error
      else
        return redirect_game
      end
    elsif @verb == "POST" && @path == "/start_game"
      if @response.game.nil?
        return redirect_start_game
      else
        return forbidden
      end
    else
      return not_found
    end
  end
end
