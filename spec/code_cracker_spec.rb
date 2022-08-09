# Tests for CodeCracker

require_relative 'spec_helper'

RSpec.describe CodeCracker do
  let(:codecracker) { described_class.new }

  context 'setup' do
    it 'exists' do
      expect(codecracker).to be_a(described_class)
    end
  end

  context 'provided date' do
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
  end

  context 'longer message test' do
    it '#crack with a different message' do
      expected = {
        decryption: 'oh hello world end',
        date: '291018',
        key: '62774'
      }

      expect(codecracker.crack('bkyesojlnzmozgybag', '291018')).to eq(expected)
    end
  end

  context "today's date testing" do
    let(:encryptor) {double}

    it "#crack with today's date" do
      expected_encrypt = {
        :encryption=>"rekqy vtalceonc", 
        :key=>"32182", 
        :date=>Date.today.strftime('%d%m%y')
      }
      allow(encryptor).to receive(:encrypt).and_return(expected_encrypt)

      current_encrypt = encryptor.encrypt('hello world end')

      expected = {
        decryption: 'hello world end',
        date: current_encrypt[:date],
        key: current_encrypt[:key]
      }

      expect(codecracker.crack(current_encrypt[:encryption])[:decryption]).to eq(expected[:decryption])
    end

    it "#crack with today's date and a different message" do
      expected_encrypt = {
        :encryption=>"o aighdzsppmup", 
        :key=>"56085", 
        :date=>"090822"
      }
      allow(encryptor).to receive(:encrypt).and_return(expected_encrypt)

      current_encrypt = encryptor.encrypt('hola world end')

      expected = {
        decryption: 'hola world end',
        date: Date.today.strftime('%d%m%y'),
        key: current_encrypt[:key]
      }

      expect(codecracker.crack(current_encrypt[:encryption])[:decryption]).to eq(expected[:decryption])
    end
  end

  context 'special characters' do
    let(:encryptor) { double }

    it "#crack with today's date and a special characters" do
      expected_encrypt = {
        :encryption=>"j0b@boecnwil!!!***qqpw", 
        :key=>"51362", 
        :date=>"090822"
      }
      
      allow(encryptor).to receive(:encrypt).and_return(expected_encrypt)
      
      current_encrypt = encryptor.encrypt('h0l@ worlds !!!*** end')

      expected = {
        decryption: 'h0l@ worlds !!!*** end',
        date: current_encrypt[:date],
        key: current_encrypt[:key]
      }

      expect(codecracker.crack(current_encrypt[:encryption])[:decryption]).to eq(expected[:decryption])
    end
  end
end
