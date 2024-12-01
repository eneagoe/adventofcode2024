#!/usr/bin/env ruby -w

first = File.open(ARGV[0]).map do
  _1.split(/\s+/).map(&:to_i)
end.transpose.map(&:sort).reduce(&:zip).sum { |(a, b)| (a - b).abs }

puts first
