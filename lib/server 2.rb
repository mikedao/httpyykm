require 'pry'
require 'socket'
class Serv
  attr_reader :tcp_server,
              :client,
              :request_lines
  def initialize(port)
    @tcp_server = TCPServer.new(port)
  end

  def begin_connection
    @client = @tcp_server.accept
    puts "Connection established"
  end

  def receive_request_lines
    puts "Receiving Request Lines:"
    @request_lines = []
    # binding.pry
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
      @request_lines.compact!
    end
    puts "Request Lines Received:"
    puts @request_lines
    return @request_lines
  end

  def read_body_from_post(bytes)
    @client.read(bytes)
  end


  def terminate
    @client.close
    puts "Connection Terminated"
  end

end
# while server.begin_connection
#   server.receive_request_lines
#   server.response(server.request_lines)
#   server.diagnostics
#   server.terminate
# end
