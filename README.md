# Live Code Challenge

Write a program that validates a given input.

The validation criteria is the following.

    The length of the string must be between 10 and 15 characters.
    The string must include at least 3 numbers.
    The string must include at least 4 uppercase characters.

When the criteria is not met, the program will throw a custom exception that has a message indicating the invalid criteria.

For example ,the string “too-short” will include the 3 messages.

    [

      “The length of the input must be between 10 and 15 characters”,

      “The input must include at least 3 numbers”,

      “The input must include at least 4 uppercase characters”

    ]

We want a descriptive error message when the validation fails.

The code has to be implemented taking into account that the validation requirements may change over time.

We encourage you to write automated tests.

# Solution

The proposed solution tries to mimic the way ActiveRecord::Validations works.

## Validator class hierarchy

Under `Validator` module there is a class hierarchy for
describing different validators. `Validator::Base` class is the base class of the hierarchy and provides `#validate` method to be implemented in child classes.

For the sake of this exercise `Validator::DigitsMinValidator`, `Validator::LengthInRangeValidator` and `Validator::UppercaseMinValidator` are provided.

## Validations module
For achieve this goal there is a `Validations::Validatable` module which add `validate` class method, and `validate!` instance method.

`validate` class method registers the attribute and the
different validators to use depending on the validations.

`validate!` instance method run validations configured for each field and raise exception `Validations::ValidationException` with one or multiple error messages.
The current implementation follows the description for this exercise and only includes the message, future implementations could include information on the field with the error.

There is a convention to be followed: When declaring a validation option, there should be a validator matching that option.
Ex: for `length_in_range` the programs looks if exists a class in `Validator` module with the name `LengthInRangeValidator`.

Future versions could include other options for more flexibility.

## Genome program

The class `GenomeProgram` includes the `Validatable` module and uses the `validate` class method for describing the validation on the `input` field. `GenomeProgram` instances has access to `validate!` method for runing validations.

```ruby
require_relative './validations/validatable'

class GenomeProgram
  include Validations::Validatable

  attr_reader :input

  validate :input, length_in_range: (10..15), digits_min: 3, uppercase_min: 4

  def initialize(input)
    @input = input
  end
end
```

## Test

Tests implemented in `genome_program_test.rb` file can be executed in a terminal using: `ruby genome_program_test.rb`. They cover the test for this exercise.

Those tests use `Test::Unit` Ruby framework.
