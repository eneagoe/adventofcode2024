#!/usr/bin/env ruby -w

def valid?(arr)
  dir = arr[0] < arr[1]

  arr.each_cons(2).all? { |(a, b)| (a < b) == dir && (a - b).abs.between?(1, 3) }
end

levels = File.open(ARGV[0]).map do
  _1.split(/\s+/).map(&:to_i)
end

first = levels.count do |level|
  valid?(level)
end

puts first

second = levels.count do |level|
  # brute-force it, input size is small
  valid?(level) || (0...level.size).any? do |i|
    valid?(level[...i] + level[i + 1..])
  end
end

puts second
