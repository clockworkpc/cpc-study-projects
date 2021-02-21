require './lib/codewars/alphabet_position'

RSpec.describe Codewars::AlphabetPosition do
  it 'returns string of integers' do
    string = "The sunset sets at twelve o' clock."
    result = '20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11'
    expect(subject.alphabet_position(string)).to eq(result)
  end

  it 'returns string of integers' do
    string = "The sunset sets::: at twelve o' clock."
    result = '20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11'
    expect(subject.alphabet_position(string)).to eq(result)
  end

  it 'returns an empty string' do
    expect(subject.alphabet_position("-.-'")).to be_empty
  end
end
