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

  let(:sample_input_corrected) do
    <<~HEREDOC
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      nop -4
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
    it 'returns last command before break' do
      instructions = subject.instructions(sample_input)
      res = subject.execute(instructions)
      expect(res[:log].last).to eq({ cmd: :jmp, index: 4, value: -3 })
    end

    it 'returns [1,1,6] for corrected sample input' do
      instructions = subject.instructions(sample_input_corrected)
      res = subject.execute(instructions)
      expect(res[:accumulator]).to eq([1, 1, 6])
    end

    # it 'returns last command for puzzle_input' do
    #   instructions = subject.instructions(puzzle_input)
    #   res = subject.execute(puzzle_input)
    # end

    it 'corrects puzzle_input and returns the sum' do
      instructions = subject.instructions(puzzle_input)
      # res = subject.execute(instructions)

      # error = instructions[374]
      # error[:cmd] = :nop

      error = instructions[282]
      error[:cmd] = :nop

      res = subject.execute(instructions)
      require 'pry'; binding.pry
      # expect(true).to eq(false)

      # [
      #   { index: 373, cmd: :nop, value: -19 },
      #   { index: 374, cmd: :jmp, value: 114 }
      # ]

      # error = instructions[374]
      # error[:cmd] = :nop
      # res = subject.execute(instructions)
      # puts res[:accumulator].sum
    end
  end

  describe 'Part 1' do
    it 'converts texts into Array of Hashes' do
      expect(subject.instructions(sample_input)).to eq(sample_instructions)
    end

    it 'returns [1,1,3] for sample input' do
      instructions = subject.instructions(sample_input)
      res = subject.execute(instructions)
      expect(res[:accumulator]).to eq([1, 1, 3])
    end

    it 'returns a sum of 5 for sample input' do
      expect(subject.accumulator_sum(sample_input)).to eq(5)
    end

    it 'returns 1_941 for puzzle_input' do
      instructions = subject.instructions(puzzle_input)
      res = subject.accumulator_sum(puzzle_input)
      expect(res).to eq(1_941)
    end
  end
end
