lanternfish = []
File.open(ARGV[0], 'r') do |f|
  lanternfish = f.readline(chomp: true).split(',').map(&:to_i)
end

# puts lanternfish.to_s
80.times do
  lanternfish += Array.new(lanternfish.count(&:zero?), 9)
  lanternfish = lanternfish.map { |f| f.zero? ? 7 : f }
  lanternfish = lanternfish.map { |f| f - 1 }
  # puts lanternfish.to_s
end

puts lanternfish.count
