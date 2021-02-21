require './lib/codewars/anagram'

RSpec.describe Codewars::Anagram do
  it 'returns ["a"]' do
    expect(subject.anagrams('a', %w[a b c d])).to eq(['a'])
  end

  it 'returns %w[ab ba]' do
    result = %w[ab ba]
    wrong = %w[aa bb cc ac bc cd]
    expect(subject.anagrams('ab', result + wrong)).to eq(%w[ab ba])
  end

  it 'returns %w[aabb bbaa abab baba baab]' do
    result = %w[aabb bbaa abab baba baab]
    wrong = %w[abcd abbba baaab abbab abbaa babaa]
    expect(subject.anagrams('abba', result + wrong)).to eq(result)
  end
end
