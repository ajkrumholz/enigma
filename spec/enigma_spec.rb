# require_relative 'spec_helper'

# RSpec.describe Enigma do
#   let(:enigma) { described_class.new }
#   let(:message) { 'hello world' }
#   let(:key) { '02715' }
#   let(:date) { '040895' }
  
#   it 'exists' do
#     expect(enigma).to be_a(described_class)
#   end
  
#   it '#keygen' do
#     allow(enigma).to receive(:keygen).and_return("12345")
#     expect(enigma.keygen).to eq("12345")
#   end

#   it '#character_set' do
#     expect(enigma.character_set).to eq(('a'..'z').to_a << ' ')
#   end

#   it '#today_date' do
#     expect(enigma.today_date).to eq(Date.today.strftime('%d%m%y'))
#   end

#   it '#key_array' do
#     expect(enigma.key_array(key)[0]).to eq(2)
#     expect(enigma.key_array(key)[1]).to eq(27)
#     expect(enigma.key_array(key)[2]).to eq(71)
#     expect(enigma.key_array(key)[3]).to eq(15)
#   end

#   it '#offset_hash' do
#     expect(enigma.offset_array(date)[0]).to eq(1)
#     expect(enigma.offset_array(date)[1]).to eq(0)
#     expect(enigma.offset_array(date)[2]).to eq(2)
#     expect(enigma.offset_array(date)[3]).to eq(5)
#   end

#   it '#generate_final_offsets' do
#     expected = [3, 27, 73, 20]
#     expect(enigma.generate_final_offsets(key, date)).to eq(expected)
#   end
# end
  