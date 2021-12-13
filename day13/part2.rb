points = []
instructions = []
File.open(ARGV[0], 'r') do |f|
  lines = f.readlines(chomp: true)
  divider = lines.index('')
  points = lines[0..(divider - 1)].map { |line| line.split(',').map(&:to_i) }

  instructions = lines[(divider + 1)..-1].map do |line|
    [line.split('=').first[-1], line.split('=').last.to_i]
  end
end

max_x = instructions.find { |a, _b| a == 'x' }[1] * 2 + 1
max_y = instructions.find { |a, _b| a == 'y' }[1] * 2 + 1
puts max_x
puts max_y

# Build array
data = Array.new(max_x) { Array.new(max_y, 0) }

points.each do |x, y|
  data[x][y] = 1
end

def execute(instruction, data)
  axis = instruction[0]
  split = instruction[1]

  data = data.transpose if axis == 'y'

  side_a = data[0..(split-1)]
  side_b = data[split..-1].reverse

  result =
    side_a.map.with_index do |row, y|
      row.map.with_index do |p, x|
        p == 1 || side_b[y][x] == 1 ? 1 : 0
      end
    end

  result = result.transpose if axis == 'y'

  result
end

instructions.each do |i|
  data = execute(i, data)
end

data.transpose.each { |r| puts r.map { |c| c.zero? ? '.' : '#' }.join }
