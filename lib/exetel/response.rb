module Exetel
  
  # Used to parse HTTP responses returned from Exetel API calls.
  class Response

    class << self
      
      # Returns the HTTP response body data as a hash.
      # - TODO - CLean this up
      def parse(response_type, http_response)
        response_keys = Exetel::Response::TypeKeys[response_type]
        body = http_response.body.gsub("\n", '')
        response = Hash[*response_keys.zip(body.split("|")).flatten]
        raise Exetel::API::Error.new(response) if response[:status] == "0"
        response
      end
    end
    
  end
end