# frozen_string_literal: true

require 'password_manager/password'

RSpec.describe PasswordManager::Password do
  context 'default' do
    subject { described_class.new }

    it '#update creates new passwords' do
      new_password = subject.update('password')
      expect(new_password).not_to eq 'password'
      expect(new_password.length).to be_between(12, 20)
      expect(new_password).to match(/[A-Za-z!@#$%^&*(),.?":{}|<>]+/)
    end
  end

  context 'different options' do
    OPTION = {
      min_length: 2,
      max_length: 5,
      mix_case: false,
      special_chars: false
    }.freeze
    subject { described_class.new(OPTION) }

    it '#update implements Faker::Internet#passwords' do
      new_password = subject.update('password')
      expect(new_password).not_to eq 'password'
      expect(new_password.length).to be_between(2, 5)
      expect(new_password).to match(/[a-z]+/)
      expect(new_password).not_to match(/[A-Z!@#$%^&*(),.?":{}|<>]+/)
    end
  end
end
