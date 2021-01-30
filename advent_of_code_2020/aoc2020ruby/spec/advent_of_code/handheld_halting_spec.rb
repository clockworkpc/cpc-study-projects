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
      cmd0: { nop: 0 },
      cmd1: { acc: 1 },
      cmd2: { jmp: 4 },
      cmd3: { acc: 3 },
      cmd4: { jmp: -3 },
      cmd5: { acc: -99 },
      cmd6: { acc: 1 },
      cmd7: { jmp: -4 },
      cmd8: { acc: 6 }
    ]
  end

  it 'converts texts into Array of Hashes' do
    expect(subject.instructions(sample_input)).to eq(sample_instructions)
  end

  it 'returns accumulator = 5 for sample input' do
    expect(subject.execute_instructions(sample_input)).to eq(5)
  end
end
