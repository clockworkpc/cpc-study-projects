require './lib/advent_of_code/toboggan_password_checker'

RSpec.describe AdventOfCode::TobogganPasswordChecker do
  let(:sample_input_text) { '1-3 a abcde' }

  let(:sample_lines) do
    [
      '1-3 a abcde',
      '1-3 b cdefg',
      '2-9 c ccccccccc'
    ]
  end

  let(:sample_input) do
    [
      [[1, 3], 'a', 'abcde'],
      [[1, 3], 'b', 'cdefg'],
      [[2, 9], 'c', 'ccccccccc']
    ]
  end

  let(:day_02_input) { File.readlines('./spec/fixtures/day_02_input.txt') }

  it 'validates a valid password' do
    check = subject.valid_password?(positions: [1, 3],
                                    substring: 'a',
                                    password: 'abcde')
    expect(check).to eq(true)
  end

  it 'invalidates an invalid password' do
    check = subject.valid_password?(positions: [1, 3],
                                    substring: 'b',
                                    password: 'cdefg')
    expect(check).to eq(false)
  end

  it 'invalidates an invalid password' do
    check = subject.valid_password?(positions: [2, 9],
                                    substring: 'c',
                                    password: 'ccccccccc')
    expect(check).to eq(false)
  end

  it 'converts a string to an array of indices' do
    expect(subject.positions('1-3')).to eq([1, 3])
  end

  it 'converts a line to a password array' do
    res = subject.password_array(sample_input_text)
    expect(res).to eq(sample_input.first)
  end

  it 'returns valid passwords' do
    res = subject.valid_passwords(sample_lines)
    expect(res).to eq(%w[abcde])
  end

  it 'returns valid passwords for Day 02, Part 2' do
    res = subject.valid_passwords(day_02_input)
    expect(res.count > 0).to eq(true)
    puts res.count
  end
end
