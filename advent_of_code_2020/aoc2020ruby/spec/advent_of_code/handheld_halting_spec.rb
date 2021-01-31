require './lib/advent_of_code/handheld_halting'

RSpec.describe AdventOfCode::HandheldHalting do
  let(:puzzle_input) { File.read('./spec/fixtures/input_day_08.txt') }

  let(:sample_input) do
    <<~HEREDOC
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    HEREDOC
  end

  let(:sample_instructions) do
    [
      { index: 0, cmd: :nop, value: 0 },
      { index: 1, cmd: :acc, value: +1 },
      { index: 2, cmd: :jmp, value: +4 },
      { index: 3, cmd: :acc, value: +3 },
      { index: 4, cmd: :jmp, value: -3 },
      { index: 5, cmd: :acc, value: -99 },
      { index: 6, cmd: :acc, value: +1 },
      { index: 7, cmd: :jmp, value: -4 },
      { index: 8, cmd: :acc, value: +6 }
    ]
  end

  describe 'Part 2' do
  end

  describe 'Part 1' do
    it 'converts texts into Array of Hashes' do
      expect(subject.instructions(sample_input)).to eq(sample_instructions)
    end

    # it 'returns [1,1,3] for sample input' do
    #   expect(subject.execute_instructions(sample_input)).to eq([1, 1, 3])
    # end

    it 'returns a sum of 5 for sample input' do
      expect(subject.accumulator_sum(sample_input)).to eq(5)
    end

    # it 'returns 1_941 for puzzle_input' do
    #   res = subject.accumulator_sum(puzzle_input)
    #   expect(res).to eq(1_941)
    # end
  end
end
