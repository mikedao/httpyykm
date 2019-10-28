class ParseRequest
  attr_reader :verb,
              :path,
              :protocol,
              :host,
              :port,
              :content_length,
              :origin,
              :accept

  def initialize(request_lines)
    @verb           = request_lines[0].split[0]
    @path           = request_lines[0].split[1]
    @protocol       = request_lines[0].split[2]
    @host           = request_lines[1].split[1].split(':')[0]
    @port           = request_lines[1].split[1].split(':')[1]
    @content_length = request_lines[3].split[1].to_i
    @origin         = request_lines[1].split[1].split(':')[0]
    @accept         = request_lines.find do |line|
                        line.split[0] == "Accept:"
                      end
  end

  def diagnostics
    "<pre>
    Verb: #{verb}
    Path: #{path}
    Host: #{host}
    Port: #{port}
    Origin: #{origin}
    #{accept}
    </pre>"
  end
end
