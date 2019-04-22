# frozen_string_literal: true

require 'password_manager/configuration'

TEST_COFIG = <<~HEREDOC
  salt: "VgJyUZY3/Eu7u1gO0u4QIw=="
  password: dGVzdA==
HEREDOC

RSpec.describe PasswordManager::Configuration do
  context described_class.new do
    let(:path) { File.expand_path(PasswordManager::Configuration::LOCATION) }

    it { is_expected.to have_attributes(password: nil, salt: nil) }

    it '#load sets attributes' do
      allow(File).to receive(:open)
        .with(path, File::RDONLY)
        .and_return(TEST_COFIG)
      subject.load
      is_expected.to have_attributes(
        password: 'dGVzdA==',
        salt: 'VgJyUZY3/Eu7u1gO0u4QIw=='
      )
    end

    it '#save fails if file exists at LOCATION' do
      allow(File).to receive(:open)
      .with(path,  File::CREAT | File::WRONLY | File::EXCL)
      .and_raise(Errno::EEXIST)
      expect { subject.save('new', 'salty') }.to raise_error(Errno::EEXIST)
    end
  end
end
