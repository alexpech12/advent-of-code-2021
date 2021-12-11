lanternfish = []

File.open(ARGV[0], 'r') do |f|
  lanternfish = f.readline(chomp: true).split(',').map(&:to_i)
end

# Index is timer value
counts = (0..8).map { |i| lanternfish.count { |f| f == i } }
puts counts.to_s

256.times do |i|
  zero_count = counts[0]
  counts = counts[1..-1] + [zero_count]
  counts[6] += zero_count
  puts "#{i}: #{counts} => #{counts.sum}"
end
