data = []
File.open(ARGV[0], 'r') do |f|
  data = f.readlines(chomp: true).map do |line|
    input,output = line.split('|')
    input = input.split(' ').map(&:chomp)
    output = output.split(' ').map(&:chomp)
    [input, output]
  end
end

puts data.sum { |input, output| output.count { |x| [2,3,4,7].include?(x.length) } }
