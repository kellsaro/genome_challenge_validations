require_relative './base'

module Validator
  class DigitsMinValidator < Validator::Base
    attr_reader :target, :value

    def initialize(value)
      @value = value
    end

    def validate(target)
      @target = target
      return [message] unless digits_count >= value
      []
    end

    private

      def digits_count
        target.chars.delete_if{|ch| not ('0'..'9').include?(ch) }.count
      end

      def message
        "The string must include at least #{value} numbers"
      end
  end
end
