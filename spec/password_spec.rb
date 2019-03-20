# frozen_string_literal: true

require 'password_manager/password'

RSpec.describe PasswordManager::Password do
  it {
    is_expected.to have_attributes(password: nil,
                                   options: {
                                     max_length: 20,
                                     min_length: 12,
                                     mix_case: true,
                                     special_chars: true
                                   })
  }

  it '#update implements Faker::Internet#passwords' do
    creds = described_class.new
    expect(Faker::Internet).to receive(:password).with(
      *PasswordManager::Password::DEFAULT_OPTS.values
    ).and_return('test')
    creds.update
  end

  it '#update creates new passwords' do
    creds = described_class.new('password')
    allow(Faker::Internet).to receive(:password).and_return('password', 'test')
    creds.update
    expect(creds.password).not_to eq 'password'
  end
end
