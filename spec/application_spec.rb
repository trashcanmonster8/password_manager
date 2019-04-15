# frozen_string_literal: true

require 'password_manager/application'

RSpec.describe PasswordManager::Application do
  subject { PasswordManager::Application.new }

  specify 'prints version' do
    expect { subject.version }.to output("v#{PasswordManager::VERSION}\n").to_stdout
  end
end
