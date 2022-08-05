require_relative 'spec_helper'

RSpec.describe Enigma do
  let(:enigma) { described_class.new }
  let(:message) { "hello world" }
  let(:key) { "02715" }
  let(:date) { "040895" }
  
  it 'exists' do
    expect(enigma).to be_a(described_class)
  end

  context 'encryption' do
    it '#encrypt' do
      expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
    end

    it '#encrypt with inconsistent casing and punctuation' do
      expected = {
        encryption: "keder ohulw!!",
        key: "02715",
        date: "040895"
      }
      
      expect(enigma.encrypt("HeLlo wOrld!!", "02715", "040895")).to eq(expected)
    end

    it '#encrypt with inconsistent casing' do
      expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      
      expect(enigma.encrypt("HeLlo wOrld", "02715", "040895")).to eq(expected)
    end
  end

  context 'decryption' do

    it '#decrypt' do
      expected = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }

      expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
    end

    it '#decrypt with inconsistent casing' do
      expected = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }

      expect(enigma.decrypt("kEdeR Ohulw", "02715", "040895")).to eq(expected)
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

  context 'cracking the code' do

    it '#encrypt testing' do
      expected =  {
            encryption: "vjqtbeaweqihssi",
            date: "291018",
            key: "08304"
          }
      expect(enigma.encrypt("hello world end", "08304", "291018")).to eq(expected)
    end

    it '#crack with provided date' do
      expected = {
            decryption: "hello world end",
            date: "291018",
            key: "08304"
          }

      expect(enigma.crack("vjqtbeaweqihssi", "291018")).to eq(expected)
    end

    xit "#crack with today's date" do
      expected = {
        decryption: "hello world end",
        date: "05082022",
        key: ""
      }

      expect(enigma.crack("vjqtbeaweqihssi")).to eq(expected)
    end
  end
end
