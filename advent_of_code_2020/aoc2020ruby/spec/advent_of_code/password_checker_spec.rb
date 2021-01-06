require './lib/advent_of_code/password_checker.rb'

RSpec.describe AdventOfCode::PasswordChecker do
  let(:sample_input) do
    [
      [(1..3), 'a', 'abcde'],
      [(1..3), 'b', 'cdefg'],
      [(2..9), 'c', 'ccccccccc']
    ]
  end

  let(:day_02_input) { File.readlines('./spec/fixtures/day_02_input.txt').map(&:to_i) }

  let(:pw_check_01) { described_class.new }

  # let(:pw_check_02) { described_class.new(sample_input) }

  it 'validates a valid password' do
    sample = simple_input[0]
    check = described_class.new.valid_password?(instance_range: (1..3),
                                                substring: 'a',
                                                password: 'abcde')
    expect(check).to eq(true)
  end
  it 'validates a valid password' do
    check = described_class.new.valid_password?(instance_range: (1..3),
                                                substring: 'a',
                                                password: 'abcde')
    expect(check).to eq(true)
  end

  it 'invalidates an invalid password' do
    check = described_class.new.valid_password?(instance_range: (1..3),
                                                substring: 'b',
                                                password: 'cdefg')
    expect(check).to eq(false)
  end

  it 'converts a string to an instance range' do
    expect(subject.convert_string_to_instance_range('1-3')).to eq((1..3))
  end
end
