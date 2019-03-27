# frozen_string_literal: true

RSpec.describe PasswordManager::Encryption do
  describe 'encrypt' do
    let(:password) { 'woohoosecret' }
    let(:plaintext) { 'its private' }

    it 'returns a non-nil string other than plaintext or the password' do
      result = PasswordManager::Encryption.encrypt(plaintext, password)
      expect(result).not_to be_nil
      expect(result).to be_a String
      expect(result).not_to match plaintext
      expect(result).not_to match password
    end
  end

  describe 'decrypt' do
    let(:password) { 'woohoosecret' }
    let(:plaintext) { 'its private' }

    it 'works' do
      result = PasswordManager::Encryption.decrypt(
        PasswordManager::Encryption.encrypt(plaintext, password),
        password
      )
      expect(result).to eq plaintext
    end
  end
end
