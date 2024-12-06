#!/usr/bin/env ruby -w

dirs = {
  '^' => [[-1, 0], '>'],
  '>' => [[0, 1], 'v'],
  'v' => [[1, 0], '<'],
  '<' => [[0, -1], '^']
}

pos = [-1, -1]
dx = 0
dy = 0
visited = Set.new
direction = ''

grid = File.open(ARGV[0]).readlines.map.with_index do |line, i|
  row = line.chomp.split(//)

  if row.intersect?(dirs.keys)
    direction = (row & dirs.keys).first
    dx, dy = dirs[direction][0]

    pos = [i, row.index(direction)]
  end

  row
end

visited << pos
grid[pos[0]][pos[1]] = '.'
n = grid.size
m = grid[0].size

loop do
  nx = pos[0] + dx
  ny = pos[1] + dy

  break unless nx.between?(0, n - 1) && ny.between?(0, m - 1)

  if grid[nx][ny] == '.'
    pos = [nx, ny]
    visited << pos
  else
    direction = dirs[direction][1]
    dx, dy = dirs[direction][0]
  end
end

puts visited.size
