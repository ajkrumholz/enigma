# Tests for Encryptor

require_relative 'spec_helper'

RSpec.describe Encryptor do
  let(:enigma) { Enigma.new }
  let(:encryptor) { described_class.new }

  context 'setup and basic testing' do
    it 'exists' do
      expect(encryptor).to be_a(described_class)
    end

    it '#keygen' do
      allow(encryptor).to receive(:keygen).and_return('12345')
      expect(encryptor.keygen).to eq('12345')
    end

    it '#encrypt' do
      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }

      expect(encryptor.encrypt('hello world', '02715', '040895')).to eq(expected)
    end
  end

  context 'inconsistent casing and punctuation' do
    it '#encrypt with inconsistent casing and punctuation' do
      expected = {
        encryption: 'keder ohulw!!',
        key: '02715',
        date: '040895'
      }

      expect(encryptor.encrypt('HeLlo wOrld!!', '02715', '040895')).to eq(expected)
    end

    it '#encrypt with inconsistent casing' do
      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }

      expect(encryptor.encrypt('HeLlo wOrld', '02715', '040895')).to eq(expected)
    end
  end
end
