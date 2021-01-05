RSpec.describe AdventOfCode::ExpenseReport do
  let(:sample_input) { [1721, 979, 366, 299, 675, 1456] }

  let(:day_01_input) { File.readlines('./spec/fixtures/day_01_input.txt').map(&:to_i) }

  let(:report) { described_class.new(sample_input) }

  let(:report2) { described_class.new(sample_input) }

  it 'should find the two entries that sum to 2020' do
    expect(report.special_expenses(req_count: 2, req_sum: 2020)).to eq([1721, 299])
  end

  it 'should return the product of the special entries' do
    expect(report.special_expenses_product(req_count: 2, req_sum: 2020))
      .to eq(514_579)
  end

  it 'should return correct answer for Day 01' do
    s = described_class.new(day_01_input)
    puts s.special_expenses_product(req_count: 2, req_sum: 2020)
  end

  it 'finds three entries that sum to 2020' do
    expect(report2.special_expenses(req_count: 3, req_sum: 2020))
      .to eq([979, 366, 675].sort.reverse)
  end

  it 'returns the product of the three special entries' do
    expect(report2.special_expenses_product(req_count: 3, req_sum: 2020))
      .to eq(241_861_950)
  end

  it 'should return the correct answer for Day 02' do
    s = described_class.new(day_01_input)
    se = s.special_expenses(req_count: 3, req_sum: 2020)
    sep = s.special_expenses_product(req_count: 3, req_sum: 2020)
    puts "special expenses: #{se}"
    puts "special expenses product: #{sep}"
  end
end
