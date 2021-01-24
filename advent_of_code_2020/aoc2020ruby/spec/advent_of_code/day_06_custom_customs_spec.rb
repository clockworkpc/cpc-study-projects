require './lib/advent_of_code/custom_customs'

RSpec.describe AdventOfCode::CustomCustoms do
  let(:puzzle_input) { File.read('./spec/fixtures/input_day_06.txt') }

  let(:sample_input) do
    <<~'HEREDOC'
      abc
      
      a
      b
      c
      
      ab
      ac
      
      a
      a
      a
      a
      
      b
    HEREDOC
  end

  describe 'Part 2' do
    it 'counts 3 YES for the first group' do
      lines = <<~'HEREDOC'
        abc
      HEREDOC
      expect(subject.yes_group_all(lines)).to eq(3)
    end

    it 'counts 0 YES for the second group' do
      lines = <<~'HEREDOC'
        a
        b
        c
      HEREDOC
      expect(subject.yes_group_all(lines)).to eq(0)
    end

    it 'counts 1 YES for third group' do
      lines = <<~'HEREDOC'
        ab
        ac
      HEREDOC
      expect(subject.yes_group_all(lines)).to eq(1)
    end

    it 'counts 1 YES for fourth group' do
      lines = <<~'HEREDOC'
        a
        a
        a
        a
      HEREDOC
      expect(subject.yes_group_all(lines)).to eq(1)
    end

    it 'counts 1 YES for fifth group' do
      lines = <<~'HEREDOC'
        b
      HEREDOC
      expect(subject.yes_group_all(lines)).to eq(1)
    end

    it 'counts 6 YES for all groups in sample_input' do
      expect(subject.yes_groups_all(sample_input)).to eq(6)
    end

    it 'counts X YES for all groups is puzzle_input' do
      expect(subject.yes_groups_all(puzzle_input)).to eq(3360)
    end
  end

  describe 'Part 1' do
    it 'counts YES for an individual' do
      line = 'abc'
      expect(subject.yes_individual(line)).to eq(3)
    end

    it 'counts 3 YES for a group of 3' do
      lines = <<~'HEREDOC'
        a
        b
        c
      HEREDOC
      expect(subject.yes_group_any(lines)).to eq(3)
    end

    it 'counts 3 YES for a group of 2' do
      lines = <<~HEREDOC
        ab
        ac
      HEREDOC

      expect(subject.yes_group_any(lines)).to eq(3)
    end

    it 'counts 1 YES for a group of 4' do
      lines = <<~HEREDOC
        a
        a
        a
        a
      HEREDOC

      expect(subject.yes_group_any(lines)).to eq(1)
    end

    it 'counts 1 YES for a group of 1' do
      lines = <<~HEREDOC
        b
      HEREDOC

      expect(subject.yes_group_any(lines)).to eq(1)
    end

    # it 'collects responses from all groups' do
    #   coll = [%w[a b c], %w[a b c], %w[a b c], ['a'], ['b']]
    #   expect(subject.res_groups(sample_input)).to eq(coll)
    # end

    it 'returns 11 for combined YES from all groups in sample input' do
      expect(subject.yes_groups_any(sample_input)).to eq(11)
    end

    it 'returns combined YES from all groups in puzzle input' do
      puts subject.yes_groups_any(puzzle_input)
    end
  end
end
