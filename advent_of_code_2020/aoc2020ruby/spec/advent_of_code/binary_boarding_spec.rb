require './lib/advent_of_code/binary_boarding'

RSpec.describe AdventOfCode::BinaryBoarding do
  let(:puzzle_input) { File.read('./spec/fixtures/input_day_05.txt') }

  let(:sample_input) do
    'FBFBBFFRLR'
  end

  let(:sample_text) do
    <<~HEREDOC
      FBFBBFFRLR
      BFFFBBFRRR
      FFFBBBFRRR
      BBFFBBFRLL
    HEREDOC
  end

  let(:sample_boarding_passes) do
    [
      { row: 44, column: 5, seat_id: 357 },
      { row: 70, column: 7, seat_id: 567 },
      { row: 14, column: 7, seat_id: 119 },
      { row: 102, column: 4, seat_id: 820 }
    ]
  end

  it 'returns row' do
    expect(subject.row(sample_input)).to eq(44)
  end

  it 'returns seat' do
    expect(subject.column(sample_input)).to eq(5)
  end

  it 'returns ID' do
    expect(subject.seat_id(sample_input)).to eq(357)
  end

  it 'returns boarding pass' do
    pass = { row: 44, column: 5, seat_id: 357 }
    expect(subject.boarding_pass(sample_input)).to eq(pass)
  end

  it 'returns boarding pass' do
    str = 'BFFFBBFRRR'
    pass = { row: 70, column: 7, seat_id: 567 }
    expect(subject.boarding_pass(str)).to eq(pass)
  end

  it 'returns boarding pass' do
    str = 'FFFBBBFRRR'
    pass = { row: 14, column: 7, seat_id: 119 }
    expect(subject.boarding_pass(str)).to eq(pass)
  end

  it 'returns boarding pass' do
    str = 'BBFFBBFRLL'
    pass = { row: 102, column: 4, seat_id: 820 }
    expect(subject.boarding_pass(str)).to eq(pass)
  end

  it 'returns boarding passes' do
    expect(subject.boarding_passes(sample_text)).to eq(sample_boarding_passes)
  end

  it 'returns highest seat ID' do
    expect(subject.highest_seat_id(sample_text)).to eq(820)
  end

  it 'returns high seat ID for input' do
    puts subject.highest_seat_id(puzzle_input)
  end

  describe 'median left tests' do
    it 'returns median left 63 for (0..127)' do
      ary = (0..127).to_a
      expect(subject.median_left(ary)).to eq(63)
    end

    it 'returns median left 31 for (0..63)' do
      ary = (0..63).to_a
      expect(subject.median_left(ary)).to eq(31)
    end

    it 'returns median left 15 for (0..31)' do
      ary = (0..31).to_a
      expect(subject.median_left(ary)).to eq(15)
    end

    it 'returns median left 7 for (0..15)' do
      ary = (0..15).to_a
      expect(subject.median_left(ary)).to eq(7)
    end

    it 'returns median left 3 for (0..7)' do
      ary = (0..7).to_a
      expect(subject.median_left(ary)).to eq(3)
    end

    it 'returns median left 1 for (0..3)' do
      ary = (0..3).to_a
      expect(subject.median_left(ary)).to eq(1)
    end

    it 'returns median left 0 for (0..1)' do
      ary = (0..1).to_a
      expect(subject.median_left(ary)).to eq(0)
    end

    it 'returns median left 95 for (64..127)' do
      ary = (64..127).to_a
      expect(subject.median_left(ary)).to eq(95)
    end

    it 'returns median left 95 for (96..127)' do
      ary = (96..127).to_a
      expect(subject.median_left(ary)).to eq(111)
    end

    it 'returns median left 119 for (112..127)' do
      ary = (112..127).to_a
      expect(subject.median_left(ary)).to eq(119)
    end

    it 'returns median left 123 for (120..127)' do
      ary = (120..127).to_a
      expect(subject.median_left(ary)).to eq(123)
    end

    it 'returns median left 125 for (124..127)' do
      ary = (124..127).to_a
      expect(subject.median_left(ary)).to eq(125)
    end

    it 'returns median left 126 for (126..127)' do
      ary = (126..127).to_a
      expect(subject.median_left(ary)).to eq(126)
    end
  end
end
