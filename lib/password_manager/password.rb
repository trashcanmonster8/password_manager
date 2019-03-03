require 'faker'

module PasswordManager
  class Password
    DEFAULT_OPTS = {
      min_length: 12,
      max_length: 20,
      mix_case: true,
      special_chars: true
    }.freeze

    attr_reader :password, :options

    def initialize(**opts)
      @options = DEFAULT_OPTS.merge(opts)
    end

    def update
      new_password = @password
      new_password = Faker::Internet.password until new_password != @password
      @password = new_password
    end
  end
end
