require 'password_manager/credentials'

RSpec.describe PasswordManager::Credentials do
  it { is_expected.to have_attributes username: nil, password: nil }

  it 'creates new passwords' do
    creds = described_class.new
    old_password = creds.password
    creds.update
    expect(creds.password).not_to eq old_password
  end
end
