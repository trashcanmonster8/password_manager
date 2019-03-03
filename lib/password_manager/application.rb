require 'password_manager/password'

module PasswordManager
  class Application
    FILE = '~/.creds'.freeze
    DEFAULT_CREDS = Password::DEFAULT_OPTS.dup.merge(
      username: nil,
      password: nil
    )

    def self.run
      file = File.open(FILE, 'w')
      @@creds = YAML.safe_load(file.read)
      application
      f.write(@@creds.to_yaml).close
    end

    def self.application
      puts 'What account do you want to update?'
      account = gets.chomp.to_sym
      cred = @@creds.fetch(account, DEFAULT_CREDS)
      puts "Do you want to update the creds for #{account}"
      puts "Current creds\n   username: #{cred[:username]}\n   password: #{cred[:password]}\n"
      unless cred[:username]
        puts 'Type username'
        cred[:username] = gets.chomp
      end
      puts "Update password for #{account}"
      input = gets.chomps
      password = update?(input, password)
      @@creds[account] = cred
    end

    def self.update?(input, password)
      puts "Old password is: #{password}"
      return password if input.casecmp('n').zero?

      new_password = Password.new(password)
      new_password.Update
      puts "New password is: #{password}"
      new_password.password
    end
  end
ends
