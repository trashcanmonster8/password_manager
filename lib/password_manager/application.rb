# frozen_string_literal: true

require 'password_manager/constants'
require 'base64'
require 'securerandom'
require 'thor'
require 'yaml'

module PasswordManager
  #
  # CLI class
  #
  class Application < Thor
    include Constants

    desc 'version', 'Display current version'
    def version
      say "v#{VERSION}"
    end

    desc 'password', 'Set password'
    def password(password)
      File.open(File.expand_path(CONFIGURATION),
                File::CREAT | File::WRONLY | File::EXCL).write(
                  {
                    salt: SecureRandom.base64(16),
                    password: Base64.strict_encode64(password)
                  }.to_yaml
                )
    end
  end
end
