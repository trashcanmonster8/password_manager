# frozen_string_literal: true

require 'password_manager/password'
require 'thor'

module PasswordManager
  class Application < Thor
    FILE = '~/.creds'
    DEFAULT_CREDS = {
      username: nil,
      password: nil,
      opts: {
        min_length: 12,
        max_length: 20,
        mix_case: true,
        special_chars: true
      }
    }.freeze

    desc 'version', 'Display password_manager version'
    map %w[-v --version] => :version
    def version
      say "password_manager v#{PasswordManager::VERSION}\n"
    end
  end
end
