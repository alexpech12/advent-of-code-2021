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
    end
  end

  def point_on_line?(point)
    if vertical?
      point[0] == start[0] && point[1].between?(*[start[1], finish[1]].sort)
    elsif horizontal?
      point[1] == start[1] && point[0].between?(*[start[0], finish[0]].sort)
    else
      false
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
    next unless line.horizontal? || line.vertical?

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
