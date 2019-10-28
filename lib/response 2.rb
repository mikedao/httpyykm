class Response
  attr_reader :body,
              :header,
              :output
  def initialize(body)
    @body = body
    @output = "<html><head></head><body>#{body}</body></html>"
    @header = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
  end

  def respond_with_header
    # binding.pry
    [@header, @output]
  end

  def report_response
    "Header:\n\r#{@header}\r\nResponse:#{@output}"
  end
end
