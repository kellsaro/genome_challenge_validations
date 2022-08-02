require_relative './base'

module Validator
  class UppercaseMinValidator < Validator::Base
    attr_reader :target, :value

    def initialize(value)
      @value = value
    end

    def validate(target)
      @target = target
      return [message] unless uppercase_count >= value
      []
    end

    private

      def uppercase_count
        target.chars.delete_if { |ch| not ('A'..'Z').include?(ch) }.count
      end

      def message
        "The string must include at least #{value} uppercase characters"
      end
  end
end