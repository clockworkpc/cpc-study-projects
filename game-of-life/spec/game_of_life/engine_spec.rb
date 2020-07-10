require 'spec_helper'

RSpec.describe GameOfLife::Engine do
  it 'initializes' do
    expect(described_class.new).to be_a(GameOfLife::Engine)
  end
end
