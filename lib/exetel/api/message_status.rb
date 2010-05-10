module Exetel  
  class API
    class MessageStatus
      STATUS_MAP = {
        0 => "SMS Request Rejected",
        1 => "Sent",
        2 => "Failed"
      }
    
      def self.[](code)
        STATUS_MAP[code.to_i]
      end
    end
  end
end