#!/usr/bin/env ruby -w

dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]
trailheads = []
destinations = []
second = 0

grid = File.open(ARGV[0]).readlines.map.with_index do |line, i|
  line = line.chomp.split(//).map { _1 =~ /\d/ ? _1.to_i : -1 }

  line.each_with_index do |d, j|
    trailheads << [i, j] if d.zero?
    destinations << [i, j] if d == 9
  end

  line
end

n = grid.size
m = grid[0].size

@path_helper = lambda do |s, d, visited, c|
  visited << s

  if s == d
    c[0] += 1
  else
    dirs.each do |(dx, dy)|
      nx = s[0] + dx
      ny = s[1] + dy

      next unless nx.between?(0, n - 1) && ny.between?(0, m - 1) &&
                  grid[nx][ny] == grid[s[0]][s[1]] + 1 &&
                  !visited.include?([nx, ny])

      @path_helper.call([nx, ny], d, visited, c)
    end
  end

  visited.delete(s)
end

n = grid.size
m = grid.first.size

trailheads.product(destinations).each do |s, d|
  visited = Set.new
  c = [0]

  @path_helper.call(s, d, visited, c)

  second += c[0]
end

puts second
