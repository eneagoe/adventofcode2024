#!/usr/bin/env ruby -w

first = 0

dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]

grid = File.open(ARGV[0]).readlines.map do |line|
  line.chomp.split(//)
end

n = grid.size
m = grid.first.size

visited = Array.new(n) { Array.new(m) { false } }

dfs = lambda do |c, i, j|
  visited[i][j] = true
  cells = [[i, j]]

  dirs.each do |(dx, dy)|
    nx = i + dx
    ny = j + dy

    if nx.between?(0, n - 1) && ny.between?(0, m - 1) && !visited[nx][ny] && grid[nx][ny] == c
      cells += dfs.call(c, nx, ny)
    end
  end

  cells
end

(0...n).each do |i|
  (0...m).each do |j|
    next if visited[i][j]

    c = grid[i][j]
    cells = dfs.call(c, i, j)
    area = cells.size

    perimiter = 0

    cells.each do |(x, y)|
      px = 0
      px += 1 if x.zero? || grid[x - 1][y] != c
      px += 1 if y.zero? || grid[x][y - 1] != c
      px += 1 if x == n - 1 || grid[x + 1][y] != c
      px += 1 if y == m - 1 || grid[x][y + 1] != c

      perimiter += px
    end

    first += area * perimiter
  end
end

puts first
