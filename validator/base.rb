module Validator
  class Base
    def validate(value)
      raise StandardError("Must be implemented in child classes")
    end

    def valid?(value)
      [ validate(value) ].flatten.compact.empty?
    end
  end
end