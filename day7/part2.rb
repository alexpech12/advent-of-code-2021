crabs = []
File.open(ARGV[0], 'r') do |f|
  crabs = f.readline(chomp: true).split(',').map(&:to_i)
end

fuel_costs = []
max_position = crabs.max
fuel_costs = (0..max_position).map do |i|
  crabs.sum { |crab| (0..(crab - i).abs).sum }
end

puts fuel_costs.min.to_s
