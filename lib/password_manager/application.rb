# frozen_string_literal: true

require 'password_manager/password'

module PasswordManager
  class Application
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

    def self.run
      load
      application
      save
    end

    def self.save
      return if @@creds.empty?

      file = File.open(File.expand_path(FILE), 'w+')
      file.write(@@creds.to_yaml)
    rescue StandardError
      file&.write(@@safe.to_yaml)
    ensure
      file&.close
    end

    def self.load
      path = File.expand_path(FILE)
      text = File.exist?(path) ? File.read(path) : nil
      @@creds = @@safe = YAML.safe_load(text, [Symbol]) || {}
    end

    def self.application
      puts 'What account do you want to update?'
      account = gets.chomp
      cred = @@creds[account] || DEFAULT_CREDS
      puts "Do you want to update the creds for #{account}"
      puts "Current creds\n   username: #{cred[:username]}\n   password: #{cred[:password]}\n"
      unless cred[:username]
        puts 'Type username'
        cred[:username] = gets.chomp
      end
      puts "Update password ([nN] = no update, [rR] = new random, or type new password) #{account}"
      input = gets.chomp
      cred[:password] = update?(input, cred[:password], cred[:opts])
      puts "New password is: #{cred[:password]}"
      @@creds[account] = cred
    end

    def self.update?(input, password, opts)
      return password if input.casecmp('n').zero?

      return input unless input.casecmp('r').zero?

      new_password = Password.new(password, opts)
      new_password.update
      new_password.password
    end
  end
end
