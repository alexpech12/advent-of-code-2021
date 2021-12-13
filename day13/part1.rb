points = []
max_x = nil
max_y = nil
File.open(ARGV[0], 'r') do |f|
  lines = f.readlines(chomp: true)
  divider = lines.index('')
  points = lines[0..(divider - 1)].map { |line| line.split(',').map(&:to_i) }

  max_x = lines[divider+1].split('=').last.to_i * 2 + 1
  max_y = lines[divider+2].split('=').last.to_i * 2 + 1
end

# puts points.to_s

# Build array
# max_x = points.map { |p| p[0] }.max + 1
# max_y = points.map { |p| p[1] }.max + 1
puts max_x
puts max_y
# max_x = 1311
# max_y = 895

data = Array.new(max_x) { Array.new(max_y, 0) }

points.each do |x, y|
  data[x][y] = 1
end

data.transpose.each { |d| puts d.to_s }

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

puts(result.sum { |d| d.count(1) })