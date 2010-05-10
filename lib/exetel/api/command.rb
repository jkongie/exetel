require 'cgi'
module Exetel  
  class API
    # Represents a Exetel HTTP gateway command in the form 
    # of a complete URL (the raw, low-level request).
    class Command
      API_SERVICE_HOST = 'smsgw.exetel.com.au'
      
      def initialize(command_name, opts = {})
        @command_name = command_name
        @options = opts
      end
      
      # Returns a URL for the given parameters (a hash).
      def with_params(param_hash)
        param_string = '?' + param_hash.map { |key, value| "#{::CGI.escape(key.to_s)}=#{::CGI.escape(value.to_s)}" }.sort.join('&')
        return URI.parse(File.join(api_service_uri, command_uri + param_string))
      end
      
      protected
      
        # Return the api service uri
        # - TODO - Allow overriding of the default service host
        def api_service_uri
          api_service_host = API_SERVICE_HOST
          return "https://#{api_service_host}/sendsms/"
        end
        
        # Return the command part of the uri
        def command_uri
          return "/api_#{@command_name}.php"
        end
    end
  end
end