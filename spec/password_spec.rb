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

  it 'creates new passwords' do
    creds = described_class.new
    old_password = creds.password
    creds.update
    expect(creds.password).not_to eq old_password
  end
end
