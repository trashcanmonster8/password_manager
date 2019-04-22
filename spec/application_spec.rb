# frozen_string_literal: true

require 'password_manager/application'
require 'password_manager/constants'

TEST_COFIG = <<~HEREDOC
  salt: "VgJyUZY3/Eu7u1gO0u4QIw==\n"
  password: dGVzdA==
HEREDOC
TEST_CREDS = <<~HEREDOC

HEREDOC
TEST_CREDS_DECRYPT = <<~HEREDOC
  docker:
    :username: user
    :password: test
    :opts:
      :min_length: 12
      :max_length: 20
      :mix_case: true
      :special_chars: true
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
      allow(File).to receive(:expand_path)
        .with(PasswordManager::Constants::CONFIGURATION)
        .and_return('/usr/.password_manager')
      allow(File).to receive(:open)
        .with('/usr/.password_manager', File::CREAT | File::WRONLY | File::EXCL)
        .and_return(file_dbl)
      allow(file_dbl).to receive(:close)
      expect(file_dbl).to receive(:write)
        .with("---\n:salt: h+VrEp/1tSIbEnXtXQ1fcQ==\n:password: dGVzdA==\n")
      subject.password('test')
    end
  end
end
