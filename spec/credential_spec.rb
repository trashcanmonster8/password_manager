# frozen_string_literal: true

require 'password_manager/credential'

RSpec.describe PasswordManager::Credential do
  context described_class.new do
    it {
      is_expected.to have_attributes(
        username: nil,
        password: nil
      )
    }

    it{ is_expected.to respond_to(:username=) }

    it '#update implements Faker::Internet#passwords' do
      expect(Faker::Internet).to receive(:password).with(
        *PasswordManager::Credential::DEFAULT_OPTS.values
      ).and_return('test')
      subject.update
    end

    it '#update creates new passwords' do
      allow(Faker::Internet).to receive(:password)
        .and_return('password', 'test')
      subject.update
      expect(subject.password).not_to eq 'password'
    end
  end
end
