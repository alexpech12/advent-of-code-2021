class String
  def sort
    split('').sort.join
  end

  def includes_digit?(b)
    b.split('').all? { |c| self.include? c }
  end
end

data = []
File.open(ARGV[0], 'r') do |f|
  data = f.readlines(chomp: true).map do |line|
    input,output = line.split('|')
    input = input.split(' ').map(&:chomp)
    output = output.split(' ').map(&:chomp)
    [input, output]
  end
end

# 1. Get unique sets for digits 1,4,7,8

# 2. Find other digits that include those sets:
# - 0: Has 6 segments, includes 1,7
# - 6: Has 6 segments
# - 9: Has 6 segments, includes 1,7,4
# - 2: Has 5 segments
# - 3: Has 5 segments, includes 1,7
# - 5: Has 5 segments

# How to differentiate between 2 and 5?
# By overlapping 1 over 6, we should be able to figure out which segment is which for 1
# Then if our 2/5 digit includes the top segment of 1, it is 2, otherwise it is 5

result = data.sum do |input, output|
  one_combo = input.find { |x| x.length == 2 }
  four_combo = input.find { |x| x.length == 4 }
  seven_combo = input.find { |x| x.length == 3 }
  eight_combo = input.find { |x| x.length == 7 }
  digits = [
    input.find { |x| x.length == 6 && x.includes_digit?(one_combo) && x.includes_digit?(seven_combo) && !x.includes_digit?(four_combo) },
    one_combo,
    nil, # 2
    input.find { |x| x.length == 5 && x.includes_digit?(one_combo) && x.includes_digit?(seven_combo) && !x.includes_digit?(four_combo) },
    four_combo,
    nil, # 5
    input.find { |x| x.length == 6 && !x.includes_digit?(one_combo) && !x.includes_digit?(seven_combo) && !x.includes_digit?(four_combo) },
    seven_combo,
    eight_combo,
    input.find { |x| x.length == 6 && x.includes_digit?(one_combo) && x.includes_digit?(seven_combo) && x.includes_digit?(four_combo) }
  ]

  # Which digit in 1 is common to 6?
  one_six_wire = (digits[1].split('') & digits[6].split('')).join
  five_wire = one_six_wire
  two_wire = (one_combo.split('') - [five_wire]).join

  digits[2] = input.find do |x|
    x.length == 5 &&
      !x.includes_digit?(one_combo) &&
      !x.includes_digit?(seven_combo) &&
      !x.includes_digit?(four_combo) &&
      x.include?(two_wire)
  end

  digits[5] = input.find do |x|
    x.length == 5 &&
      !x.includes_digit?(one_combo) &&
      !x.includes_digit?(seven_combo) &&
      !x.includes_digit?(four_combo) &&
      x.include?(five_wire)
  end

  digits = digits.map { |d| d.split('').sort.join }
  output_digits = output.map { |o| digits.index(o.sort) }
  output_digits.join.to_i
end

puts result