#!/usr/bin/env ruby -w

first = File.open(ARGV[0]).map do
  _1.split(/\s+/).map(&:to_i)
end.transpose.map(&:sort).reduce(&:zip).sum { |(a, b)| (a - b).abs }

puts first

locations, appearances = File.open(ARGV[0]).map do
  _1.split(/\s+/).map(&:to_i)
end.transpose

frequencies = appearances.each_with_object(Hash.new(0)) do |location, h|
  h[location] += 1
end

puts locations.sum { _1 * frequencies[_1] }
