# frozen_string_literal: true

module PasswordManager
  class Configuration
    LOCATION =  '~/.password_manager'

    attr_reader :password, :salt

    def initialize
      @absolute_location = File.expand_path(LOCATION)
    end

    def load
      data = YAML.safe_load(File.open(@absolute_location, File::RDONLY))
      @password = data['password']
      @salt = data['salt']
    end

    def save(password, salt)
      File.open(@absolute_location,
                File::CREAT | File::WRONLY | File::EXCL) do |file|
        file.puts({
          'password' => password,
          'salt' => salt
        }.to_yaml)
      end
    end

    def to_s
      self.class.to_s
    end
  end
end
