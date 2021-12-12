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

errors = lines.map do |line|
  stack = []
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
end

SCORES = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

puts(errors.compact.reduce(0) { |agg, e| agg + SCORES[e] })
