module Validator
  class Base
    def validate(value); end

    def valid?(value)
      [ validate(value) ].flatten.compact.empty?
    end
  end
end