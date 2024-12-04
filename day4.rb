#!/usr/bin/env ruby -w

first = 0
grid = File.open(ARGV[0]).readlines.map do |line|
  line.chomp.split(//)
end

n = grid.size
m = grid.first.size

# pad the grid, makes the search easier
n.times do |i|
  grid[i] = [' '] * 3 + grid[i] + [' '] * 3
end

3.times do
  grid.unshift [' '] * (m + 6)
  grid << [' '] * (m + 6)
end

(3...n + 3).each do |i|
  (3...m + 3).each do |j|
    next if grid[i][j] != 'X'

    # check the 8 directions
    # N
    first += 1 if grid[i - 1][j] == 'M' && grid[i - 2][j] == 'A' && grid[i - 3][j] == 'S'
    # NE
    first += 1 if grid[i - 1][j + 1] == 'M' && grid[i - 2][j + 2] == 'A' && grid[i - 3][j + 3] == 'S'
    # E
    first += 1 if grid[i][j + 1] == 'M' && grid[i][j + 2] == 'A' && grid[i][j + 3] == 'S'
    # SE
    first += 1 if grid[i + 1][j + 1] == 'M' && grid[i + 2][j + 2] == 'A' && grid[i + 3][j + 3] == 'S'
    # S
    first += 1 if grid[i + 1][j] == 'M' && grid[i + 2][j] == 'A' && grid[i + 3][j] == 'S'
    # SW
    first += 1 if grid[i + 1][j - 1] == 'M' && grid[i + 2][j - 2] == 'A' && grid[i + 3][j - 3] == 'S'
    # W
    first += 1 if grid[i][j - 1] == 'M' && grid[i][j - 2] == 'A' && grid[i][j - 3] == 'S'
    # NW
    first += 1 if grid[i - 1][j - 1] == 'M' && grid[i - 2][j - 2] == 'A' && grid[i - 3][j - 3] == 'S'
  end
end

puts first
