require 'set'

data = []
File.open(ARGV[0], 'r') do |f|
  data = f.readlines(chomp: true).map { |l| l.split('').map(&:to_i) }
end

def print_data(data)
  data.each { |line| puts line.join }
end

def get_to_flash(data)
  to_flash = []
  data.each_with_index do |l, x|
    l.each_with_index do |c, y|
      to_flash << [x, y] if data[x][y] > 9
    end
  end
  to_flash
end

def flash!(data, x, y)
  [
    [x - 1, y],
    [x - 1, y + 1],
    [x - 1, y - 1],
    [x + 1, y],
    [x + 1, y - 1],
    [x + 1, y + 1],
    [x, y - 1],
    [x, y + 1]
  ].each do |x, y|
    next if x.negative? || y.negative?

    data[x][y] += 1 if data[x] && data[x][y]
  end
end

def increment_data(data)
  data.each_with_index do |l, x|
    l.each_with_index do |c, y|
      data[x][y] += 1
    end
  end
end

flash_count = 0

100.times do |i|
  # puts "Starting #{i}"
  increment_data(data)

  flashed = Set.new

  loop do
    to_flash = Set.new(get_to_flash(data)) - flashed

    # print_data(data)
    # puts "To flash: #{to_flash}"
    break if to_flash.empty?

    to_flash.each { |x, y| flash!(data, x, y) }
    flashed += to_flash
    flashed.each { |x, y| data[x][y] = 0 }

    # puts "Flashed: #{flashed}"
  end
  # flashed.each { |x, y| data[x][y] = 0 }
  flash_count += flashed.count
  # puts "Flash count: #{flash_count}"
  # print_data(data)
end

puts flash_count