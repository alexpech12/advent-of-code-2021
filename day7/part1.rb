crabs = []
File.open(ARGV[0], 'r') do |f|
  crabs = f.readline(chomp: true).split(',').map(&:to_i)
end

max_position = crabs.max
fuel_costs = (0..max_position).map do |i|
  crabs.sum { |crab| (crab - i).abs }
end

puts fuel_costs.min.to_s
