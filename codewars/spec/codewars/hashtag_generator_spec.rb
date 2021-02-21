require './lib/codewars/hashtag_generator'

RSpec.describe Codewars::HashtagGenerator do
  it 'Expected an empty string to return false' do
    expect(subject.generateHashtag('')).to eq(false)
  end

  it 'Still an empty string' do
    expect(subject.generateHashtag(' ' * 200)).to eq(false)
  end

  it 'Expected a Hashtag (#) at the beginning.' do
    expect(subject.generateHashtag('Do We have A Hashtag')).to eq('#DoWeHaveAHashtag')
  end

  it 'handles a single word.' do
    expect(subject.generateHashtag('Codewars')).to eq('#Codewars')
  end

  it 'removes spaces.' do
    expect(subject.generateHashtag('Codewars Is Nice')).to eq('#CodewarsIsNice')
  end

  it 'capitalizes first letters of words.' do
    expect(subject.generateHashtag('Codewars is nice')).to eq('#CodewarsIsNice')
  end

  it 'eliminates superfluous spaces' do
    expect(subject.generateHashtag("code#{' ' * 140}wars")).to eq('#CodeWars')
  end

  # rubocop:disable Metrics/LineLength
  it 'returns false if the final word is longer than 140 chars.' do
    string = 'Looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong Cat'
    expect(subject.generateHashtag(string)).to eq(false)
  end
  # rubocop:enable Metrics/LineLength

  it 'works' do
    expect(subject.generateHashtag('a' * 139)).to eq("#A#{'a' * 138}")
  end

  it 'Too long' do
    expect(subject.generateHashtag('a' * 140)).to eq(false)
  end
end
