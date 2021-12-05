class VentLine
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def horizontal?
    start[1] == finish[1]
  end

  def vertical?
    start[0] == finish[0]
  end

  def points
    if vertical?
      x = start[0]
      yr = [start[1], finish[1]].sort
      (yr[0]..yr[1]).to_a.map { |y| [x, y] }
    elsif horizontal?
      y = start[1]
      xr = [start[0], finish[0]].sort
      (xr[0]..xr[1]).to_a.map { |x| [x, y] }
    else
      # Diagonal
      reverse_x = start[0] > finish[0]
      reverse_y = start[1] > finish[1]

      xr = reverse_x ? (finish[0]..start[0]).to_a : (start[0]..finish[0]).to_a
      xr = xr.reverse if reverse_x

      yr = reverse_y ? (finish[1]..start[1]).to_a : (start[1]..finish[1]).to_a
      yr = yr.reverse if reverse_y

      xr.zip(yr)
    end
  end
end

File.open(ARGV[0], 'r') do |f|
  maximum = 0
  lines = f.readlines(chomp: true).map do |line|
    line.match(/(\d+),(\d+) -> (\d+),(\d+)/)
    maximum = [$1, $2, $3, $4, maximum].map(&:to_i).max
    VentLine.new([$1, $2].map(&:to_i), [$3, $4].map(&:to_i))
  end
  puts maximum

  points = Array.new(maximum + 1) { Array.new(maximum + 1, 0) }
  lines.each do |line|
    line.points.each do |p|
      points[p[1]][p[0]] += 1
    end
  end

  # points.each do |row|
  #   puts row.to_s
  # end

  result = points.sum { |row| row.count { |point| point && point > 1 } }
  puts result
end
