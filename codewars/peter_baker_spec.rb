require './lib/codewars/peter_baker'

RSpec.describe Codewars::PeterBaker do
  it 'returns 2 cakes' do
    recipe = { 'flour' => 500, 'sugar' => 200, 'eggs' => 1 }
    available = { 'flour' => 1200, 'sugar' => 1200, 'eggs' => 5, 'milk' => 200 }
    expect(subject.cakes(recipe, available)).to eq(2)
  end

  it 'returns 11 cakes' do
    recipe = { 'cream' => 200, 'flour' => 300, 'sugar' => 150, 'milk' => 100, 'oil' => 100 }
    available = { 'sugar' => 1700, 'flour' => 20_000, 'milk' => 20_000, 'oil' => 30_000, 'cream' => 5000 }
    expect(subject.cakes(recipe, available)).to eq(11)
  end

  it 'returns 0 cakes, missing ingredient' do
    recipe = { 'apples' => 4, 'flour' => 300, 'sugar' => 150, 'milk' => 100, 'oil' => 100 }
    available = { 'sugar' => 500, 'flour' => 2000, 'milk' => 2000 }
    expect(subject.cakes(recipe, available)).to eq(0)
  end

  it 'returns 0 cakes, not enough ingredients' do
    recipe = { 'apples' => 3, 'flour' => 300, 'sugar' => 150, 'milk' => 100, 'oil' => 100 }
    available = { 'sugar' => 500, 'flour' => 2000, 'milk' => 2000, 'apples' => 15, 'oil' => 20 }

    expect(subject.cakes(recipe, available)).to eq(0)
  end

  it 'returns 0 cakes, no ingredients at all' do
    recipe = { 'eggs' => 4, 'flour' => 400 }
    available = {}
    expect(subject.cakes(recipe, available)).to eq(0)
  end

  it 'returns 1 cake' do
    recipe = { 'cream' => 1, 'flour' => 3, 'sugar' => 1, 'milk' => 1, 'oil' => 1, 'eggs' => 1 }
    available = { 'sugar' => 1, 'eggs' => 1, 'flour' => 3, 'cream' => 1, 'oil' => 1, 'milk' => 1 }
    expect(subject.cakes(recipe, available)).to eq(1)
  end
end
