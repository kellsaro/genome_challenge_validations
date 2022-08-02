require_relative './validations/validatable'

class GenomeProgram
  include Validatable

  attr_reader :input

  validate :input, length_in_range: (10..15), digits_min: 3, uppercase_min: 4

  def initialize(input)
    @input = input
  end
end
