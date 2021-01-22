require './lib/advent_of_code/passport_processing'

RSpec.describe AdventOfCode::PassportProcessing do
  let(:puzzle_input) { File.read('./spec/fixtures/input_day_04.txt') }

  let(:sample_input) do
    txt = <<~'HEREDOC'
      ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
      byr:1937 iyr:2017 cid:147 hgt:183cm

      iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
      hcl:#cfa07d byr:1929

      hcl:#ae17e1 iyr:2013
      eyr:2024
      ecl:brn pid:760753108 byr:1931
      hgt:179cm

      hcl:#cfa07d eyr:2025 pid:166559648
      iyr:2011 ecl:brn hgt:59in
    HEREDOC
  end

  it 'reads four passports' do
    passports = subject.passports(sample_input)
    expect(passports.count).to eq(4)
    expect(passports.map(&:class).uniq.first).to eq(Hash)
  end

  it 'counts the first passport as valid' do
    passports = subject.passports(sample_input)
    expect(subject.valid?(passports[0])).to eq(true)
  end

  it 'counts the second passport as invalid' do
    passports = subject.passports(sample_input)
    expect(subject.valid?(passports[1])).to eq(false)
  end

  it 'counts the third passport as valid' do
    passports = subject.passports(sample_input)
    expect(subject.valid?(passports[2])).to eq(true)
  end

  it 'counts the fourth passport as valid' do
    passports = subject.passports(sample_input)
    expect(subject.valid?(passports[3])).to eq(false)
  end

  it 'counts 2 valid passports' do
    expect(subject.valid_passports(sample_input)).to eq(2)
  end

  it 'counts valid passports in puzzle input' do
    puts subject.valid_passports(puzzle_input)
    
  end
end
