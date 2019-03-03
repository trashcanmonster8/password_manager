require 'password_manager/password'

module PasswordManager
  class Application
    FILE = '~/.creds'.freeze

    def self.run
      @@creds = YAML.safe_load File.read(FILE)
      application
      File.write(FILE, 'w') { |f| f.write @@creds.to_yaml }.close
    end

    def self.application
      @@creds.each do |account, password|
        puts "Update password for #{account}"
        input = gets.chomps
        password = update?(input, password)
      end
    end

    def self.update?(input, password)
      return password if input.casecmp('n').zero?

      new_password = Password.new(password)
      new_password.Update
      puts "New password is: #{password}"
      new_password.password
      end
  end
end
