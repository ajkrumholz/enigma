require_relative 'spec_helper'

RSpec.describe Enigma do
  let(:enigma) { described_class.new }

  it 'exists' do
    expect(enigma).to be_a(described_class)
  end

  xit '#encrypt' do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end
  context 'key creation' do 
    it '#a_key' do
      expect(enigma.a_key('02715')).to eq('02')
    end

    it '#b_key' do
      expect(enigma.b_key('02715')).to eq('27')
      
    end

    it '#c_key' do
      expect(enigma.c_key('02715')).to eq('71')
      
    end

    it '#d_key' do
      expect(enigma.d_key('02715')).to eq('15')
      
    end
  end

  context 'offset creation' do
    it '#a_offset' do
      expect(enigma.a_offset("040895")).to eq("1")
    end

    it '#b_offset' do
      expect(enigma.b_offset("040895")).to eq("0")
    end

    it '#c_offset' do
      expect(enigma.c_offset("040895")).to eq("2")
    end

    it '#d_offset' do
      expect(enigma.d_offset("040895")).to eq("5")
    end
  end

  context 'final offset creation' do
    it '#final_a_offset' do
      expect(enigma.a_final('02715', '040895')).to eq(3)
    end

    it '#final_b_offset' do
      expect(enigma.b_final('02715', '040895')).to eq(27)
    end

    it '#final_c_offset' do
      expect(enigma.c_final('02715', '040895')).to eq(73)
    end

    it '#final_d_offset' do
      expect(enigma.d_final('02715', '040895')).to eq(20)
    end
  end

  xit '#decrypt' do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end
  
end