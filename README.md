Live Code Challenge

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