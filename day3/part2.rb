def filter(data, i=0, &block)
  return '' if i >= data.first.length

  digit =
    if data.length == 1
      data.first[i]
    else
      block.call(2 * data.count { |d| d[i] == '1' }, data.length) ? '1' : '0'
    end
  new_data = data.select { |d| d[i] == digit}
  digit + filter(new_data, i + 1, &block)
end

File.open(ARGV[0], 'r') do |f|
  data = f.readlines.map(&:chomp)
  ogr = filter(data) { |a, b| a >= b }
  puts "2"
  csr = filter(data) { |a, b| a < b }
  puts ogr
  puts csr
  puts ('0' + ogr).to_i(2)
  puts ('0' + csr).to_i(2)
  puts ('0' + ogr).to_i(2) * ('0' + csr).to_i(2)
end
