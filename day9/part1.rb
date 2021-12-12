data = []
File.open(ARGV[0], 'r') do |f|
  data = f.readlines(chomp: true).map { |l| l.split('').map(&:to_i) }
end

def get_surrounds(data, x, y)
  [
    data.fetch(x-1, [])[y],
    data.fetch(x, [])[y-1],
    data.fetch(x+1, [])[y],
    data.fetch(x, [])[y+1]
  ].compact
end

def find_minima_indices(data)
  indices = []
  data.each_with_index do |col, x|
    col.each_with_index do |height, y|
      if get_surrounds(data, x, y).all? { |v| height < v }
        indices << [x, y]
      end
    end
  end
  indices
end

minima_indices = find_minima_indices(data)

minima = minima_indices.map { |x, y| data[x][y] }
puts minima.sum + minima.count
