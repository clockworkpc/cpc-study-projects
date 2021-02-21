require './lib/codewars/morse_code'

RSpec.describe Codewars::MorseCode do
  let(:bits) do
    '1100110011001100000011000000111111001100111111001111110000000000000011001111110011111100111111000000110011001111110000001111110011001100000011'
  end

  let(:morse_code) { '.... . -.--   .--- ..- -.. .' }

  # it 'returns morse code from bits' do
  #   expect(subject.decode_bits(bits)).to eq(morse_code)
  # end

  it 'returns HEY JUDE' do
    expect(subject.decode_morse(morse_code)).to eq('HEY JUDE')
  end

  it 'returns SOS' do
    sos_code = '...---...'

    expect(subject.decode_morse(sos_code)).to eq('SOS')
  end
end
