#!/usr/bin/env ruby -w

# very ugly brute-force

dirs = {
  '^' => [[-1, 0], '>'],
  '>' => [[0, 1], 'v'],
  'v' => [[1, 0], '<'],
  '<' => [[0, -1], '^']
}

start = [-1, -1]
dx = 0
dy = 0
original_direction = ''
direction = ''

grid = File.open(ARGV[0]).readlines.map.with_index do |line, i|
  row = line.chomp.split(//)

  if row.intersect?(dirs.keys)
    direction = (row & dirs.keys).first
    dx, dy = dirs[direction][0]

    start = [i, row.index(direction)]
  end

  row
end
n = grid.size
m = grid[0].size
original_direction = direction

try_place = lambda do |x, y|
  direction = original_direction
  dx, dy = dirs[direction][0]

  return false if grid[x][y] == original_direction || grid[x][y] == '#'

  visited = Set.new

  visited << start
  pos = start.dup
  grid[pos[0]][pos[1]] = '.'
  grid[x][y] = '#'

  looping = false

  loop do
    nx = pos[0] + dx
    ny = pos[1] + dy

    break unless nx.between?(0, n - 1) && ny.between?(0, m - 1)

    if grid[nx][ny] == '.'
      pos = [nx, ny]

      if visited.include?([pos, direction])
        looping = true
        break
      end

      visited << [pos, direction]
    else
      direction = dirs[direction][1]
      dx, dy = dirs[direction][0]
    end
  end

  # restore grid
  grid[start[0]][start[1]] = original_direction
  grid[x][y] = '.'

  looping
end


result = (0...n).reduce(0) do |sum, i|
  sum + (0...m).count { |j| try_place.call(i, j) }
end

puts result
