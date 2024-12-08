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
  locations.combination(2).each do |a, b|
    antinodes << a
    antinodes << b

    # extend in one direction
    x0, y0 = *a
    x1, y1 = *b
    loop do
      x2 = 2 * x1 - x0
      y2 = 2 * y1 - y0
      break unless x2.between?(0, n - 1) && y2.between?(0, m - 1)

      antinodes << [x2, y2]

      x0 = x1
      y0 = y1
      x1 = x2
      y1 = y2
    end

    # extend in the other direction
    x0, y0 = *a
    x1, y1 = *b
    loop do
      x2 = 2 * x0 - x1
      y2 = 2 * y0 - y1

      break unless x2.between?(0, n - 1) && y2.between?(0, m - 1)

      antinodes << [x2, y2]

      x1 = x0
      y1 = y0
      x0 = x2
      y0 = y2
    end
  end
end

puts antinodes.size
