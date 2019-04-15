# frozen_string_literal: true

require 'password_manager/application'
require 'password_manager/constants'

TEST_COFIG = <<~HEREDOC
  salt: "VgJyUZY3/Eu7u1gO0u4QIw==\n"
  password: dGVzdA==
HEREDOC

RSpec.describe PasswordManager::Application do
  subject { PasswordManager::Application.new }

  specify 'prints version' do
    expect { subject.version }.to output("v#{PasswordManager::VERSION}\n")
      .to_stdout
  end

  context '.password_manager' do
    it 'set password' do
      file_dbl = instance_double(File)
      allow(SecureRandom).to receive(:base64)
      .and_return('h+VrEp/1tSIbEnXtXQ1fcQ==')
      allow(File).to receive(:open)
        .with(PasswordManager::Constants::CONFIGURATION, File::CREAT)
        .and_return(file_dbl)
      allow(file_dbl).to receive(:close)
      expect(file_dbl).to receive(:write)
        .with("---\n:salt: h+VrEp/1tSIbEnXtXQ1fcQ==\n:password: dGVzdA==\n")
      subject.password('test')
    end
  end
end
