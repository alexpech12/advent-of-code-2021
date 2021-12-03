File.open(ARGV[0], 'r') do |f|
  commands = f.readlines.map { |line| line.chomp.split(' ') }
  position = 0
  depth = 0
  aim = 0
  commands.each do |cmd|
    val = cmd[1].to_i
    case cmd[0]
    when 'up'
      aim -= val
    when 'down'
      aim += val
    when 'forward'
      position += val
      depth += aim*val
    end
  end
  puts position
  puts depth
  puts position * depth
end
