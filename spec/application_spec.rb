require 'password_manager/application'

RSpec.describe PasswordManager::Application do
  it '#run loads .creds file' do
    file_dbl = instance_double(File)
    expect(File).to receive(:read).with('~/.creds').and_return('---\n:test:text')
    allow(YAML).to receive(:load)
    allow(described_class).to receive(:application)
    allow(File).to receive(:write).with('~/.creds', 'w').and_return(file_dbl)
    allow(file_dbl).to receive(:write)
    allow(file_dbl).to receive(:close)
    described_class.run
  end

  it '#application requires better test as application grows' do
    pending
    expect(false).to eq true
  end
end
