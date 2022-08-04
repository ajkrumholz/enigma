require_relative 'spec_helper'

RSpec.describe Enigma do
  let(:enigma) { described_class.new }
  let(:message) { "hello world" }
  let(:key) { "02715" }
  let(:date) { "040895" }
  
  it 'exists' do
    expect(enigma).to be_a(described_class)
  end

  context 'encryption and decryption' do
    it '#encrypt' do
      expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
    end
    
    it '#decrypt' do
      expected = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }

      expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
    end

    it '#encrypt with inconsistent casing' do
      expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      
      expect(enigma.encrypt("HeLlo wOrld", "02715", "040895")).to eq(expected)
    end

    it '#decrypt with inconsistent casing' do
      expected = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }

      expect(enigma.decrypt("kEdeR Ohulw", "02715", "040895")).to eq(expected)
    end

    it '#encrypt with inconsistent casing and punctuation' do
      expected = {
        encryption: "keder ohulw!!",
        key: "02715",
        date: "040895"
      }
      
      expect(enigma.encrypt("HeLlo wOrld!!", "02715", "040895")).to eq(expected)
    end

    it '#decrypt with inconsistent casing and punctuation' do
      expected = {
        decryption: "he!!llo world",
        key: "02715",
        date: "040895"
      }

      expect(enigma.decrypt("kE!!deR Ohulw", "02715", "040895")).to eq(expected)
    end
  end

  context 'key creation' do 

    it '#keygen' do
      expect(enigma.keygen).to be_a(String)
    end
    it '#a_key' do
      expect(enigma.a_key(key)).to eq('02')
    end

    it '#b_key' do
      expect(enigma.b_key(key)).to eq('27')
      
    end

    it '#c_key' do
      expect(enigma.c_key(key)).to eq('71')
      
    end

    it '#d_key' do
      expect(enigma.d_key(key)).to eq('15')
      
    end
  end

  context 'offset creation' do
    it '#a_offset' do
      expect(enigma.a_offset(date)).to eq("1")
    end

    it '#b_offset' do
      expect(enigma.b_offset(date)).to eq("0")
    end

    it '#c_offset' do
      expect(enigma.c_offset(date)).to eq("2")
    end

    it '#d_offset' do
      expect(enigma.d_offset(date)).to eq("5")
    end
  end

  context 'final offset creation' do
    it '#final_a_offset' do
      expect(enigma.a_final(key, date)).to eq(3)
    end

    it '#final_b_offset' do
      expect(enigma.b_final(key, date)).to eq(27)
    end

    it '#final_c_offset' do
      expect(enigma.c_final(key, date)).to eq(73)
    end

    it '#final_d_offset' do
      expect(enigma.d_final(key, date)).to eq(20)
    end

    it '#generate_final_offsets' do
      expected = [3, 27, 73, 20]
      expect(enigma.generate_final_offsets(key, date)).to eq(expected)
    end
  end
end
