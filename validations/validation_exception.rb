module Validations
  class ValidationException < StandardError
    attr_reader :messages
    def initialize(messages)
      @messages = [messages].flatten
    end

    def message
      @messages.join("|").to_s
    end
  end
end