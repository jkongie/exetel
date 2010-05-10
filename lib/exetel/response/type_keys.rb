module Exetel  
  class Response
    class TypeKeys
      TYPE_MAP = { 
        :sms => [:status, :number, :reference_number, :exetel_id, :exetel_notes],
        :credit_check => [:status, :credit_limit, :exetel_notes]
        }
      def self.[](type)
        TYPE_MAP[type]
      end  
    end
  end
end