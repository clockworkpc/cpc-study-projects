require './lib/codewars/roman_numerals'

RSpec.describe Codewars::RomanNumerals do
  it 'returns 1' do
    expect(subject.solution('I')).to eq(1)
  end

  it 'returns 21' do
    expect(subject.solution('XXI')).to eq(21)
  end

  it 'returns 4' do
    expect(subject.solution('IV')).to eq(4)
  end

  it 'returns 2008' do
    expect(subject.solution('MMVIII')).to eq(2008)
  end

  it 'returns 1666' do
    expect(subject.solution('MDCLXVI')).to eq(1666)
  end
end
