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

    def initialize(password = nil, **opts)
      @password = password
      @options = DEFAULT_OPTS.merge(opts)
    end

    def update
      new_password = @password
      new_password = Faker::Internet.password(
        @options[:min_length],
        @options[:max_length],
        @options[:mix_case],
        @options[:special_chars]
      ).split("").shuffle.join until new_password != @password
      @password = new_password
    end
  end
end
