#!/usr/bin/env ruby -w

antinodes = Set.new
antennas =  Hash.new { |hash, key| hash[key] = [] }

grid = File.open(ARGV[0]).readlines.map.with_index do |line, i|
  line = line.chomp.split(//)

  line.each_with_index do |c, j|
    antennas[c] << [i, j] if c != '.'
  end

  line
end

n = grid.size
m = grid[0].size

antennas.each_value do |locations|
  # the points we're looking for are the symmetrical with respects to each
  # for each pair of antennas of same type
  locations.combination(2).each do |a, b|
    x1 = 2 * b[0] - a[0]
    y1 = 2 * b[1] - a[1]

    antinodes << [x1, y1] if x1.between?(0, n - 1) && y1.between?(0, m - 1)

    x2 = 2 * a[0] - b[0]
    y2 = 2 * a[1] - b[1]

    antinodes << [x2, y2] if x2.between?(0, n - 1) && y2.between?(0, m - 1)
  end
end

puts antinodes.size
