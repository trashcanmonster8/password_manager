RSpec.describe PasswordManager::Credentials do
  it { is_expected.to have_attributes username: nil, password: nil }
end
