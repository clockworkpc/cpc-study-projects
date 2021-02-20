require './lib/codewars/domain_name.rb'

RSpec.describe Codewars::DomainName do
  it 'returns google' do
    expect(subject.domain_name('http://google.com')).to eq('google')
    expect(subject.domain_name('http://google.co.jp')).to eq('google')
  end

  it 'returns xakep' do
    expect(subject.domain_name('www.xakep.ru')).to eq('xakep')
  end

  it 'returns youtube' do
    expect(subject.domain_name('https://youtube.com')).to eq('youtube')
  end
end
