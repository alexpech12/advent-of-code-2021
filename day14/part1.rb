template = ''
rules = {}

File.open(ARGV[0], 'r') do |f|
  lines = f.readlines(chomp: true)
  template = lines[0].split('')
  lines[2..-1].each do |l|
    rules[l[0..1]] = l.split(' -> ').last
  end
end

puts template
puts rules.to_s

10.times do
  new_template = []
  template.each_cons(2).each do |pair|
    new_template += [pair[0], rules[pair.join]]
  end
  new_template << template.last
  template = new_template
  puts template.join
end

results = template.tally
puts results.to_s
puts results.values.max - results.values.min