require_relative './base'

module Validator
  class LengthInRangeValidator < Validator::Base
    attr_reader :target, :range

    def initialize(range)
      @range = range
    end

    def validate(target)
      @target = target
      return [message] unless range.include?(target.length)
      []
    end

    private

      def message
        "The length of the string must be between #{range.min} and #{range.max} characters"
      end
  end
end