require 'password_manager/password'

module PasswordManager
  class Application
    FILE = '~/.creds'.freeze
    DEFAULT_CREDS = Password::DEFAULT_OPTS.dup.merge(
      username: nil,
      password: nil
    )

    def self.run
      file = File.open(File.expand_path(FILE), 'w+')
      @@creds = @@safe = YAML.safe_load(file.read) || {}
      application
      file.write(@@creds.to_yaml).close
    rescue
      file.write(@@safe.to_yaml).close
    end

    def self.application
      puts 'What account do you want to update?'
      account = gets.chomp
      cred = @@creds[account] || {}
      puts "Do you want to update the creds for #{account}"
      puts "Current creds\n   username: #{cred[:username]}\n   password: #{cred[:password]}\n"
      unless cred[:username]
        puts 'Type username'
        cred[:username] = gets.chomp
      end
      puts "Update password ([nN] = no update, [rR] = new random, or type new password) #{account}"
      input = gets.chomp
      cred[:password] = update?(input, cred[:password])
      puts "New password is: #{cred[:password]}"
      @@creds[account] = cred
    end

    def self.update?(input, password)
      return password if input.downcase == 'n'

      return input unless input.downcase == 'r'

      new_password = Password.new(password)
      new_password.update
      new_password.password
    end
  end
end
