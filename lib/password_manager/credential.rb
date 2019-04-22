# frozen_string_literal: true

require 'faker'

module PasswordManager
  class Credential
    DEFAULT_OPTS = {
      min_length: 12,
      max_length: 20,
      mix_case: true,
      special_chars: true
    }.freeze

    attr_accessor :username
    attr_reader :password

    def initialize(username = nil, password = nil, **opts)
      @username = username
      @password = password
      @options = DEFAULT_OPTS.merge(opts)
    end

    def update(username = nil)
      new_password = @password.dup
      new_password = Faker::Internet.password(
        @options[:min_length],
        @options[:max_length],
        @options[:mix_case],
        @options[:special_chars]
      ).split('').shuffle.join until new_password != @password
      @password = new_password
    end

    def to_s
      "#{@username}:#{@password}"
    end
  end
end
