# frozen_string_literal: true

module PasswordManager
  class Configuration
    LOCATION =  '~/.password_manager'

    attr_reader :password, :salt

    def initialize
      @absolute_location = File.expand_path(LOCATION)
    end

    def load
      data = YAML.load(File.open(@absolute_location, File::RDONLY))
      @password = data['password']
      @salt = data['salt']
    end

    def to_s
      self.class.to_s
    end
  end
end
