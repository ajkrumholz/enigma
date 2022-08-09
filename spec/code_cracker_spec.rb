require_relative 'spec_helper'

RSpec.describe CodeCracker do
  let(:enigma) { Enigma.new }
  let(:encryptor) { Encryptor.new }
  let(:codecracker) { described_class.new }

  it 'exists' do
    expect(codecracker).to be_a(described_class)
  end

  it '#encrypt testing' do
    expected = {
      encryption: 'vjqtbeaweqihssi',
      date: '291018',
      key: '08304'
    }
    expect(encryptor.encrypt('hello world end', '08304', '291018')).to eq(expected)
  end

  it '#crack with provided date' do
    expected = {
      decryption: 'hello world end',
      date: '291018',
      key: '08304'
    }

    expect(codecracker.crack('vjqtbeaweqihssi', '291018')).to eq(expected)
  end

  it '#crack with a different provided date' do
    expected = {
      decryption: 'hello world end',
      date: '020385',
      key: '33030'
    }

    expect(codecracker.crack('vjqtbeaweqihssi', '020385')).to eq(expected)
  end

  it '#crack with a different message' do
    encryptor.encrypt('oh hello world end', '62774', '291018')

    expected = {
      decryption: 'oh hello world end',
      date: '291018',
      key: '62774'
    }

    expect(codecracker.crack('bkyesojlnzmozgybag', '291018')).to eq(expected)
  end

  it "#crack with today's date" do
    current_encrypt = encryptor.encrypt('hello world end')

    expected = {
      decryption: 'hello world end',
      date: Date.today.strftime("%d%m%y"),
      key: current_encrypt[:key]
    }

    expect(codecracker.crack(current_encrypt[:encryption])[:decryption]).to eq(expected[:decryption])
  end

  it "#crack with today's date and a different message" do
    current_encrypt = encryptor.encrypt('hola world end')

    expected = {
      decryption: 'hola world end',
      date: Date.today.strftime("%d%m%y"),
      key: current_encrypt[:key]
    }
    
    expect(codecracker.crack(current_encrypt[:encryption])[:decryption]).to eq(expected[:decryption])
  end

  it "#crack with today's date and a special characters" do
    current_encrypt = encryptor.encrypt("h0l@ worlds !!!*** end")

    expected = {
      decryption: "h0l@ worlds !!!*** end",
      date: Date.today.strftime("%d%m%y"),
      key: current_encrypt[:key]
    }

    expect(codecracker.crack(current_encrypt[:encryption])[:decryption]).to eq(expected[:decryption])
  end
end