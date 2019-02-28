require 'faker'

module PasswordManager
  class Credentials
    attr_reader :username, :password

    def initialize; end

    def update
      new_password = @password
      new_password = Faker::Internet.password until new_password != @password
      @password = new_password
    end
  end
end
