template = ''
rules = {}

File.open(ARGV[0], 'r') do |f|
  lines = f.readlines(chomp: true)
  template = lines[0].split('')
  lines[2..-1].each do |l|
    rules[l[0..1]] = l.split(' -> ').last
  end
end

puts template.to_s
puts rules.to_s

tally = {}
pair_tally = {}

def add_to_tally(tally, val, amt = 1)
  if tally.key?(val)
    tally[val] += amt
  else
    tally[val] = amt
  end
end

template.each_cons(2) { |pair| add_to_tally(pair_tally, pair.join) }
template.each { |c| add_to_tally(tally, c) }

# puts tally.to_s
40.times do |i|
  puts i

  keys = pair_tally.keys
  new_pair_tally = {}
  keys.each do |key|
    key_to_insert = rules[key]
    p1, p2 = key.split('')
    k1 = "#{p1}#{key_to_insert}"
    k2 = "#{key_to_insert}#{p2}"

    # puts "Key #{key}: Adding #{pair_tally[key]} #{k1} and #{k2}"

    # We've removed all of 'key' and replaced with the same amount of k1 and k2
    add_to_tally(new_pair_tally, k1, pair_tally[key])
    add_to_tally(new_pair_tally, k2, pair_tally[key])

    # We've increased the number of 'keys_to_insert' by the number of pairs
    add_to_tally(tally, key_to_insert, pair_tally[key])
    pair_tally[key] = 0
  end

  new_pair_tally.each { |k, v| add_to_tally(pair_tally, k, v) }
  # puts pair_tally.to_s
  # puts tally.to_s
end

puts tally.values.max - tally.values.min
# 2959788056211