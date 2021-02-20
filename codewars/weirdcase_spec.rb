require './lib/codewars/weirdcase'

RSpec.describe Codewars::Weirdcase do
  it 'returns ThIs' do
    expect(subject.weirdcase('This')).to eq('ThIs')
  end

  it 'returns Is' do
    expect(subject.weirdcase('is')).to eq('Is')
  end

  it 'returns ThIs Is A TeSt' do
    expect(subject.weirdcase('This is a test')).to eq('ThIs Is A TeSt')
  end
end
