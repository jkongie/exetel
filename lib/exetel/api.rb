module Exetel
  # This module provides the core implementation of the Exetel SMS HTTP Service
  class API
    attr_accessor :auth_options
    
    def initialize(auth_options={})
      @auth_options = auth_options
    end
    
    # Sends a message +message_text+ to +recipient+. 
    #
    # Additional options:
    #    :sender - the from number/name(default="")
    #    :msg_type - The encoding type of message(default=text)
    #    :ref_number - An optional reference number for local tracking
    # Returns a new message ID if successful.
    def send_message(recipient, message_text, opts={})
      valid_options = { :sender => "", :messagetype => "Text" }
      valid_options.merge!(:sender => opts[:sender]) if opts[:sender]
      valid_options.merge!(:messagetype => opts[:msg_type]) if opts[:msg_type]
      valid_options.merge!(:referencenumber => opts[:ref_number]) if opts[:ref_number]
      recipient = recipient.join(",")if recipient.is_a?(Array)
      response = execute_command('sms',
                                 { :mobilenumber => recipient, :message => message_text}.merge(valid_options)
                                )
      response = parse_response(:sms, response)
      response.is_a?(Array) ? response.map { |r| r[:status] } : response[:status]
    end
    
    # Requests for the amount of credit remaining
    #
    # Returns a response hash
    def credit_check
      response = execute_command('sms_credit')
      response = parse_response(:credit_check, response)
    end
    
    protected
      def execute_command(command_name, parameters={}) #:nodoc:
        executor = CommandExecutor.new(auth_options, true)
        result = executor.execute(command_name, parameters)
      end
    
      def parse_response(response_type, raw_response) #:nodoc:
        Exetel::Response.parse(response_type, raw_response)
      end
  end
end

