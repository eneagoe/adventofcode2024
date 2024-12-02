#!/usr/bin/env ruby -w

levels = File.open(ARGV[0]).map do
  _1.split(/\s+/).map(&:to_i)
end

first = levels.count do |level|
  dir = level[0] < level[1]

  level.each_cons(2).all? { |(a, b)| (a < b) == dir && (a - b).abs.between?(1, 3) }
end

puts first
