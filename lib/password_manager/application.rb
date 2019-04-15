# frozen_string_literal: true

require 'password_manager/version'
require 'thor'

module PasswordManager
  class Application < Thor
    desc 'version', 'Display current version'
    def version
      say "v#{PasswordManager::VERSION}"
    end
  end
end
