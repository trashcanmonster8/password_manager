# frozen_string_literal: true

require 'password_manager/application'

RSpec.describe PasswordManager::Application do
  it 'prints version' do
    expect { subject.version }.to output("password_manager v#{PasswordManager::VERSION}\n").to_stdout
  end
end
