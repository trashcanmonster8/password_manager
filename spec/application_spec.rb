require 'password_manager/application'

RSpec.describe PasswordManager::Application do
  it '#run loads' do
    expect(described_class).to receive(:load)
    allow(described_class).to receive(:application)
    allow(described_class).to receive(:save)
    described_class.run
  end

  it '#run application' do
    allow(described_class).to receive(:load)
    expect(described_class).to receive(:application)
    allow(described_class).to receive(:save)
    described_class.run
  end

  it '#run save' do
    allow(described_class).to receive(:load)
    allow(described_class).to receive(:application)
    expect(described_class).to receive(:save)
    described_class.run
  end

  it '#load' do
    pending
    expect(false).to eq true
  end

  it '#application' do
    pending
    expect(false).to eq true
  end

  it '#save' do
    pending
    expect(false).to eq true
  end
end
