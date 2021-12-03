File.open(ARGV[0], 'r') do |f|
  data = f.readlines.map(&:chomp)
  counts = Array.new(data.first.length, 0)
  data.each do |d|
    d.split('').each_with_object(counts).with_index { |(bin, agg), i| agg[i] += bin.to_i }
  end

  gamma = counts.map { |c| c > data.length / 2 ? '1' : '0' }.join.to_i(2)
  epsilon = counts.map { |c| c > data.length / 2 ? '0' : '1' }.join.to_i(2)
  puts gamma
  puts epsilon
  puts gamma * epsilon
end
