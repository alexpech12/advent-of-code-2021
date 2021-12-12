lines = []
File.open(ARGV[0], 'r') do |f|
  lines = f.readlines(chomp: true)
end

BRACKETS = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}.freeze

corrupts = []
incompletes = []
lines.map do |line|
  stack = []
  error =
    line.split('').find do |c|
      if BRACKETS.keys.include? c
        # Opening...
        stack << c
        false
      else
        # Check close
        if BRACKETS[stack.last] == c
          stack = stack[0..-2]
          false
        else
          # puts "#{line}   Expected #{BRACKETS[stack.last]}, got #{c}"
          true
        end
      end
    end

  if error
    # Corrupted line
    corrupts << error
  else
    # Incomplete line
    incompletes << stack
  end
end

SCORES = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

# Convert incomplete sections to required closing sequences
results = incompletes.map { |inc| inc.reverse.map { |c| BRACKETS[c] } }
puts incompletes.map(&:join).to_s
puts results.map(&:join).to_s

# Score each sequence
scores = results.map { |r| r.reduce(0) { |a, c| a * 5 + SCORES[c] } }

puts scores.to_s

# Find middle score
puts scores.sort[scores.length / 2]
