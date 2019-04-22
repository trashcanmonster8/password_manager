# frozen_string_literal: true

require 'password_manager/configuration'

TEST_COFIG = <<~HEREDOC
  salt: "VgJyUZY3/Eu7u1gO0u4QIw=="
  password: dGVzdA==
HEREDOC

RSpec.describe PasswordManager::Configuration do
  context described_class.new do
    it { is_expected.to have_attributes(password: nil, salt: nil) }

    it '#load sets attributes' do
      path = File.expand_path(PasswordManager::Configuration::LOCATION)
      allow(File).to receive(:open)
        .with(path, File::RDONLY)
        .and_return(TEST_COFIG)
      subject.load
      is_expected.to have_attributes(
        password: 'dGVzdA==',
        salt: "VgJyUZY3/Eu7u1gO0u4QIw=="
      )
    end
  end
end
