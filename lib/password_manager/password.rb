# frozen_string_literal: true

require 'faker'

module PasswordManager
  #
  # Password object wraps Faker::Internet#password
  #
  class Password
    DEFAULT_OPTS = {
      min_length: 12,
      max_length: 20,
      mix_case: true,
      special_chars: true
    }.freeze

    def initialize(**opts)
      @options = DEFAULT_OPTS.dup.merge(opts)
    end

    def update(password = '')
      new_password = password
      new_password = Faker::Internet.password(
        @options[:min_length],
        @options[:max_length],
        @options[:mix_case],
        @options[:special_chars]
      ).split('').shuffle.join until new_password != password
      new_password
    end
  end
end
