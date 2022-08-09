# Tests for Decryptor

require_relative 'spec_helper'

RSpec.describe Decryptor do
  let(:decryptor) { described_class.new }

  context 'setup and basic test' do
    it 'exists' do
      expect(decryptor).to be_a(described_class)
    end

    it '#decrypt' do
      expected = {
        decryption: 'hello world',
        key: '02715',
        date: '040895'
      }

      expect(decryptor.decrypt('keder ohulw', '02715', '040895')).to eq(expected)
    end
  end

  context 'inconsistent casing and punctuation' do
    it '#decrypt with inconsistent casing' do
      expected = {
        decryption: 'hello world',
        key: '02715',
        date: '040895'
      }

      expect(decryptor.decrypt('kEdeR Ohulw', '02715', '040895')).to eq(expected)
    end

    it '#decrypt with inconsistent casing and punctuation' do
      expected = {
        decryption: 'he!!llo world',
        key: '02715',
        date: '040895'
      }

      expect(decryptor.decrypt("ke!!olgtzojeg", '02715', '040895')).to eq(expected)
    end
  end
end
