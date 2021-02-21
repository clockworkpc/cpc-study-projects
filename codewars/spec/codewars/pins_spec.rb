require './lib/codewars/pins'

RSpec.describe Codewars::Pins do
  let(:expectations) { JSON.parse(File.read('./spec/fixtures/pins.json')) }

  it 'returns the correct value' do
    expectations.each do |pin, result|
      expect(subject.get_pins(pin).sort).to eq(result.sort)
    end
  end
end
