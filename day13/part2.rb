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

# data.transpose.each { |d| puts d.to_s }

def execute(instruction, data)
  axis = instruction[0]
  split = instruction[1]

  if axis == 'y'
    top_half = data.transpose[0..(split-1)]
    bottom_half = data.transpose[split..-1]

    bottom_half_flipped = bottom_half.reverse

    # puts
    # top_half.each { |d| puts d.to_s }
    # puts
    # bottom_half.each { |d| puts d.to_s }
    # puts

    top_half.map.with_index do |row, y|
      row.map.with_index do |p, x|
        p == 1 || bottom_half_flipped[y][x] == 1 ? 1 : 0
      end
    end.transpose
  else
    left_side = data[0..(split-1)]
    right_side = data[split..-1]

    right_side_flipped = right_side.reverse

    # puts
    # left_side.transpose.each { |d| puts d.to_s }
    # puts
    # right_side.transpose.each { |d| puts d.to_s }
    # puts
    # right_side_flipped.transpose.each { |d| puts d.to_s }

    left_side.map.with_index do |row, y|
      row.map.with_index do |p, x|
        p == 1 || right_side_flipped[y][x] == 1 ? 1 : 0
      end
    end
  end
end

# data.each { |r| puts r.map { |c| c.zero? ? '.' : '#' }.join }
instructions.each do |i|
  data = execute(i, data)
  # data.each { |r| puts r.map { |c| c.zero? ? '.' : '#' }.join }
end
# data.each { |r| puts r.map { |c| c.zero? ? '.' : '#' }.join }
data.transpose.each { |r| puts r.map { |c| c.zero? ? '.' : '#' }.join }

return
# puts(data.sum { |d| d.count(1) })

# top_half = data.transpose[0..(max_y/2)]
# bottom_half = data.transpose[(max_y/2)..-1]
left_side = data[0..(max_x/2)]
right_side = data[(max_x/2)..-1]

right_side_flipped = right_side.reverse

# top_half.each { |d| puts d.to_s }
# puts
# bottom_half.each { |d| puts d.to_s }

# bottom_half_flipped = bottom_half.reverse

left_side.transpose.each { |d| puts d.to_s }
puts
right_side.transpose.each { |d| puts d.to_s }
puts
right_side_flipped.transpose.each { |d| puts d.to_s }

# Add halves together
result =
left_side.map.with_index do |row, y|
    row.map.with_index do |p, x|
      p == 1 || right_side_flipped[y][x] == 1 ? 1 : 0
    end
  end
# result =
#   top_half.map.with_index do |row, y|
#     row.map.with_index do |p, x|
#       p == 1 || bottom_half_flipped[y][x] == 1 ? 1 : 0
#     end
#   end

# result.each { |d| puts d.to_s }

result.each { |r| puts r.map { |c| c.zero? ? '.' : '#' }.join }

puts(result.sum { |d| d.count(1) })