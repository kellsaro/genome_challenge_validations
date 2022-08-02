require 'test/unit'
require_relative './genome_program'
require_relative './validations/validation_exception'

class GenomeProgramTest < Test::Unit::TestCase
  LENGTH_VALIDATION_MESSAGE = 'The length of the string must be between 10 and 15 characters'.freeze
  DIGITS_VALIDATION_MESSAGE = 'The string must include at least 3 numbers'.freeze
  UPPERCASE_VALIDATION_MESSAGE = 'The string must include at least 4 uppercase characters'.freeze

  def test_length_in_range_validation
    program = GenomeProgram.new("SOME123")

    assert_raise Validations::ValidationException do
      program.validate!
    end

    begin
      program.validate!
    rescue Validations::ValidationException => ex
      assert_equal LENGTH_VALIDATION_MESSAGE, ex.message
    end
  end

  def test_string_must_include_at_least_3_numbers
    program = GenomeProgram.new("some iNPUT")

    assert_raise Validations::ValidationException do
      program.validate!
    end

    begin
      program.validate!
    rescue Validations::ValidationException => ex
      assert_equal DIGITS_VALIDATION_MESSAGE, ex.message
    end
  end

  def test_string_must_include_at_least_4_uppercase_characters
    program = GenomeProgram.new("some input 123")

    assert_raise Validations::ValidationException do
      program.validate!
    end

    begin
      program.validate!
    rescue Validations::ValidationException => ex
      assert_equal UPPERCASE_VALIDATION_MESSAGE, ex.message
    end
  end

  def test_all_validations_are_executed
    program = GenomeProgram.new("too-short")

    assert_raise Validations::ValidationException do
      program.validate!
    end

    begin
      program.validate!
    rescue Validations::ValidationException => ex
      assert_equal 3, ex.messages.length
      assert ex.messages.include? LENGTH_VALIDATION_MESSAGE
      assert ex.messages.include? DIGITS_VALIDATION_MESSAGE
      assert ex.messages.include? UPPERCASE_VALIDATION_MESSAGE
    end
  end
end
