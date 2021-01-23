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

  describe 'Part 1' do
    it 'reads four passports' do
      passports = subject.passports(sample_input)
      expect(passports.count).to eq(4)
      expect(passports.map(&:class).uniq.first).to eq(Hash)
    end

    it 'counts the first passport as valid' do
      passports = subject.passports(sample_input)
      expect(subject.valid_passport_keys?(passports[0])).to eq(true)
    end

    it 'counts the second passport as invalid' do
      passports = subject.passports(sample_input)
      expect(subject.valid_passport_keys?(passports[1])).to eq(false)
    end

    it 'counts the third passport as valid' do
      passports = subject.passports(sample_input)
      expect(subject.valid_passport_keys?(passports[2])).to eq(true)
    end

    it 'counts the fourth passport as valid' do
      passports = subject.passports(sample_input)
      expect(subject.valid_passport_keys?(passports[3])).to eq(false)
    end

    it 'counts 2 valid passports' do
      expect(subject.passports_with_valid_keys(sample_input)).to eq(2)
    end

    it 'counts valid passports in puzzle input' do
      res = subject.passports_with_valid_keys(puzzle_input)
      expect(res).to eq(256)
    end
  end

  describe 'Part 2' do


    it 'accepts a birth year between 1920 and 2002' do
      (1920..2002).to_a.each do |n|
        expect(subject.valid_birth_year?(n)).to eq(true)
      end
    end

    it 'rejects a birth year outside 1920-2002' do
      [1919, 2003].each do |n|
        expect(subject.valid_birth_year?(n)).to eq(false)
      end
    end

    it 'accepts an issue year between 2010 and 2020' do
      (2010..2020).to_a.each do |n|
        expect(subject.valid_issue_year?(n)).to eq(true)
      end
    end

    it 'rejects an issue year outside of 2010-2020' do
      [2009, 2021].each do |n|
        expect(subject.valid_issue_year?(n)).to eq(false)
      end
    end

    it 'accepts an expiration year between 2020 and 2030' do
      (2020..2030).to_a.each do |n|
        expect(subject.valid_expiration_year?(n)).to eq(true)
      end
    end

    it 'rejects an expiration year outside of 2020-2030' do
      [2019, 2031].each do |n|
        expect(subject.valid_expiration_year?(n)).to eq(false)
      end
    end

    it 'accepts a metric height between 150 and 193 centimetres' do
      (150..193).to_a.each do |n|
        expect(subject.valid_metric_height?(n)).to eq(true)
        str = "#{n}cm"
        expect(subject.valid_height?(str)).to eq(true)
      end
    end

    it 'rejects metric height outside of 150-193 centimetres' do
      [149, 194].each do |n|
        expect(subject.valid_metric_height?(n)).to eq(false)
        str = "#{n}cm"
        expect(subject.valid_height?(str)).to eq(false)
      end
    end

    it 'accepts an imperial height between 59 and 76 inches' do
      (59..76).to_a.each do |n|
        expect(subject.valid_imperial_height?(n)).to eq(true)
        str = "#{n}in"
        expect(subject.valid_height?(str)).to eq(true)
      end
    end

    it 'rejects imperial height outside of 59-76 inches' do
      [58, 77].each do |n|
        expect(subject.valid_imperial_height?(n)).to eq(false)
        str = "#{n}in"
        expect(subject.valid_height?(str)).to eq(false)
      end
    end

    it 'rejects a height entry without the suffix' do
     expect(subject.valid_height?('155')).to eq(false) 
    end

    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.

    it 'accepts a valid hair colour of #123abc' do
      expect(subject.valid_hair_colour?('#123abc')).to eq(true)
    end

    it 'rejects an invalid hair colour of #123abz' do
      expect(subject.valid_hair_colour?('#123abz')).to eq(false)
    end

    it 'rejects an invalid hair colour of 123abc' do
      expect(subject.valid_hair_colour?('123abc')).to eq(false)
    end

    it 'accepts a valid eye colour' do
      %w[amb blu brn gry grn hzl oth].each do |str|
        expect(subject.valid_eye_colour?(str)).to eq(true)
      end 
    end

    it 'rejects an invalid eye colour' do
      %w[amber blue brown grey green hazel other ylw blk].each do |str|
        puts str
        expect(subject.valid_eye_colour?(str)).to eq(false)
      end
    end

    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    # cid (Country ID) - ignored, missing or not.

    # ecl valid:   brn
    # ecl invalid: wat

    # pid valid:   000000001
    # pid invalid: 0123456789 


  end
end
