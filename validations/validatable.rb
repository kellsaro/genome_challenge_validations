require 'debug'

require_relative './validation_exception'
require_relative '../validator/base'
require_relative '../validator/digits_min_validator'
require_relative '../validator/length_in_range_validator'
require_relative '../validator/uppercase_min_validator'

module Validations::Validatable
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def validate!
    errors ||= []
    instance_variables.each do |inst_attr|
      field_sym = inst_attr.to_s.slice(1..).to_sym

      self.class.field_validators[field_sym]&.each do |validator|
        errors << validator.validate(eval(field_sym.to_s))
      end
    end

    errors.flatten!.compact!

    raise Validations::ValidationException.new(errors) unless errors.empty?
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  module ClassMethods
    def field_validators
      @field_validators ||= Hash.new([])
    end

    def validate(field, *args)
      return if args&.empty?

      hash = args[0]

      hash.each_pair do |validator, arg|
        validator_instance = build_validator_instance(validator, arg)
        add_validator_to_field(field, validator_instance)
      end
    end

    def build_validator_instance(validator, arg)
      klass_name = validator.to_s.split('_').push('validator').collect(&:capitalize).join
      validator_string_for_eval = "Validator::#{klass_name}.new(#{arg})"
      validator_instance = eval(validator_string_for_eval)
    end

    def add_validator_to_field(field_name, validator)
      field_validators[field_name] << validator
    end
  end
end
