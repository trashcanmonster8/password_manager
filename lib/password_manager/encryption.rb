# frozen_string_literal: true

require 'openssl'
require 'base64'

module PasswordManager
  #
  # Encryption using AES-256-CBC
  # Key generated using a password with OpenSSL:KDF#pbkdf2_hmac
  #
  module AESCrypt
    CIPHER_TYPE = 'AES-256-CBC'
    SALT = "VgJyUZY3/Eu7u1gO0u4QIw==\n"
    KDF_OPTS = {
      salt: Base64.decode64(SALT.dup),
      iterations: 20_000,
      length: 32,
      hash: 'sha1'
    }.freeze

    class << self
      def decrypt(armored_iv_and_ciphertext, pass)
        ciphertext = [armored_iv_and_ciphertext].pack('H*')
        aes = OpenSSL::Cipher.new(CIPHER_TYPE)
        aes.decrypt
        aes.key = OpenSSL::KDF.pbkdf2_hmac(pass, KDF_OPTS.dup)
        aes.iv = ciphertext.slice!(0, 16)
        aes.update(ciphertext) + aes.final
      end

      def encrypt(data, pass)
        aes = OpenSSL::Cipher.new(CIPHER_TYPE)
        aes.encrypt
        aes.iv = iv = aes.random_iv
        aes.key = OpenSSL::KDF.pbkdf2_hmac(pass, KDF_OPTS.dup)
        iv_and_ciphertext = iv + aes.update(data) + aes.final
        iv_and_ciphertext.unpack1('H*')
      end
    end
  end
end
