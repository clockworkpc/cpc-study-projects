RSpec.describe AdventOfCode::ExpenseReport do
  let(:sample_input) { [1721, 979, 366, 299, 675, 1456] }

  let(:input) do
    lines = File.readlines('./spec/fixtures/day_01_input.txt')
    lines.map(&:to_i)
  end

  let(:report) { described_class.new(sample_input) }

  let(:report2) { described_class.new(sample_input) }

  it 'should find the two entries that sum to 2020' do
    expect(report.special_expenses).to eq([1721, 299])
  end

  it 'should return the product of the special entries' do
    expect(report.special_expenses_product).to eq(514_579)
  end

  it 'should return correct answer' do
    s = described_class.new(input)
    puts s.special_expenses_product
  end

  it 'finds three entries that sum to 2020' do
    expect(report2.special_expenses(count: 3)).to eq([979, 366, 675])
  end

  # it 'returns the product of the three special entries' do
  #   expect(report2.special_expenses_product(count: 3)).to eq(241_861_950)
  # end
end
