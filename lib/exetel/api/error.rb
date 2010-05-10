module Exetel
  class API
    
    # Exetel API Error exception
    class Error < StandardError
      attr_reader :status, :message
      
      def initialize(response)
        @status = Exetel::API::MessageStatus[response[:status]]
        @message = response[:exetel_notes]
        puts "Error: #{@status} => #{@message}"
      end
    end
  end
end