require_relative 'spec_helper'

RSpec.describe Cryptable do
  let(:enigma) { Enigma.new }
  let(:message) { 'hello world' }
  let(:key) { '02715' }
  let(:date) { '040895' }

  context 'key creation' do
    it '#keygen' do
      expect(enigma.keygen).to be_a(String)
    end

    it '#dategen' do
      expect(enigma.dategen).to eq(Date.today.strftime('%d%m%y'))
    end

    it '#key_hash' do
      expect(enigma.key_array(key)[0]).to eq(2)
      expect(enigma.key_array(key)[1]).to eq(27)
      expect(enigma.key_array(key)[2]).to eq(71)
      expect(enigma.key_array(key)[3]).to eq(15)
    end
  end

  context 'offset creation' do
    it '#offset_hash' do
      expect(enigma.offset_array(date)[0]).to eq(1)
      expect(enigma.offset_array(date)[1]).to eq(0)
      expect(enigma.offset_array(date)[2]).to eq(2)
      expect(enigma.offset_array(date)[3]).to eq(5)
    end
  end

  context 'final offset creation' do
    it '#generate_final_offsets' do
      expected = [3, 27, 73, 20]
      expect(enigma.generate_final_offsets(key, date)).to eq(expected)
    end
  end
end
