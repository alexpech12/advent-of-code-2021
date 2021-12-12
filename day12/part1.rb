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

# Paths go both ways
paths += paths.map(&:reverse)

def map_routes(paths, existing_route)
  location = existing_route.last
  # puts "Route #{existing_route}"

  # If we're at the end, this path is complete
  return [existing_route] if location == 'end'

  # Get all routes from current location
  options = paths.select { |src, dst| src == location && (dst.small_cave? ? !existing_route.include?(dst) : true) }

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
