require 'set'

paths = []
File.open(ARGV[0], 'r') do |f|
  paths = f.readlines(chomp: true).map { |l| l.split('-') }
end

class String
  def small_cave?
    self == downcase
  end
end

class Array
  def visited_small_cave_twice?
    small_caves = select(&:small_cave?)

    small_caves.count != small_caves.uniq.count
  end
end

# Paths go both ways
paths += paths.map(&:reverse)

def map_routes(paths, existing_route)
  location = existing_route.last
  # puts "Route #{existing_route}"

  # If we're at the end, this path is complete
  return [existing_route] if location == 'end'

  # Get all routes from current location
  options = paths.select do |src, dst|
    src == location &&
      dst != 'start' &&
      (dst.small_cave? ? (!existing_route.include?(dst) || !existing_route.visited_small_cave_twice?) : true)
  end

  # puts "Options: #{options}"

  # If there are no options, this path is complete
  return [existing_route] if options.empty?

  # Recurse!
  results = options.map { |option| map_routes(paths, existing_route + [option[1]]) }.flatten(1)

  # puts "Returning #{results}"
  results
end

routes = map_routes(paths, ['start'])

# Remove dead ends
routes = routes.select { |r| r.last == 'end' }

puts routes.count
