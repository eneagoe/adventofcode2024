#!/usr/bin/env ruby -w

dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]
trailheads = []
destinations = []
first = 0

grid = File.open(ARGV[0]).readlines.map.with_index do |line, i|
  line = line.chomp.split(//).map { _1 =~ /\d/ ? _1.to_i : -1 }

  line.each_with_index do |d, j|
    trailheads << [i, j] if d.zero?
    destinations << [i, j] if d == 9
  end

  line
end

n = grid.size
m = grid.first.size

trailheads.product(destinations).each do |s, d|
  visited = Set.new
  q = [s]
  visited << s
  reached = false

  until q.empty?
    node = q.shift

    if node == d
      reached = true
      break
    end

    dirs.each do |(dx, dy)|
      nx = node[0] + dx
      ny = node[1] + dy

      next unless nx.between?(0, n - 1) && ny.between?(0, m - 1) &&
                  grid[nx][ny] == grid[node[0]][node[1]] + 1 &&
                  !visited.include?([nx, ny])

      q << [nx, ny]
      visited << [nx, ny]
    end
  end

  first += 1 if reached
end

puts first
