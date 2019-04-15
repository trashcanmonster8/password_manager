# frozen_string_literal: true

require 'password_manager/constants'
require 'thor'

module PasswordManager
  class Application < Thor
    include Constants

    desc 'version', 'Display current version'
    def version
      say "v#{VERSION}"
    end

    desc 'password', 'Set password'
    def password(password)
      File.open(CONFIGURATION, File::CREAT).write(
        {
          salt: SecureRandom.base64,
          password: Base64.strict_encode64(password)
        }.to_yaml
      )
    end
  end
end
