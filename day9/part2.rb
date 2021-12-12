require 'set'

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

# Each basin starts as a single point
basin_sets = minima_indices.map { |m| Set.new([m]) }

# For each basin...
basin_sets = basin_sets.map do |basin_set|
  edge_set = Set.new(basin_set)

  until edge_set.empty?
    # Get surrounds of edge points
    # puts "----------"
    # puts "Edges: #{edge_set}"
    surrounds = edge_set.map do |e|
      [
        [e[0]-1,e[1]],
        [e[0],e[1]-1],
        [e[0]+1,e[1]],
        [e[0],e[1]+1]
      ]
    end.flatten(1)
    surrounds.reject! { |e| e[0].negative? || e[1].negative? || data.fetch(e[0], [])[e[1]].nil? }
    surrounds_set = Set.new(surrounds) - basin_set
    # puts "Surrounds: #{surrounds_set}"

    # Remove values of 9
    surrounds_set.delete_if { |point| data[point[0]][point[1]] == 9 }

    # puts "Surrounds to add: #{surrounds_set}"

    # Replace edge points with new surrounds
    edge_set = surrounds_set

    # Add new edge points to basin points
    basin_set += edge_set

    # puts "Basin: #{basin_set}"
  end
  basin_set
end

# puts basin_sets.to_s
result = basin_sets.map(&:count).sort.reverse[0..2].reduce(:*)
puts result
