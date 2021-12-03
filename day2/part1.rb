File.open(ARGV[0], 'r') do |f|
  commands = f.readlines.map { |line| line.chomp.split(' ') }
  sums = %w[forward up down].map do |dir|
    commands.select { |c| c[0] == dir }.sum { |c| c[1].to_i }
  end
  puts sums[0] * (sums[2] - sums[1])
end
