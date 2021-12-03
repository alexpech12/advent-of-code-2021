File.open(ARGV[0], 'r') do |f|
  puts(f.readlines.each_cons(2).count { |a, b| b.to_i > a.to_i })
end
