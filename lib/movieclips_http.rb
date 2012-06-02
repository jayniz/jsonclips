module Movieclips
  module HTTP

    def self.request(path, query_string = '')
      uri = "#{BASE + path}?"+query_string
      puts "FORWARDING TO #{uri}"
      conn = EM::HttpRequest.new(uri)
      get = conn.get
      {
        status: get.response_header.status,
        body:   parse_response(get.response)
      }
    end

    def self.parse_response(xml)
      xml.gsub!("<?xml version='1.0' encoding='utf-8'",
                '<?xml version="1.0" encoding="utf-8"')
      obj = Nori.parse(xml)
      puts JSON.pretty_generate(obj)
      obj
    end
  end
end
