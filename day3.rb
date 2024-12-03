#!/usr/bin/env ruby -w

first = 0
File.open(ARGV[0]).readlines.each do |line|
  line.scan(/mul\((\d{1,3}),(\d{1,3})\)/).each do |a, b|
    first += a.to_i * b.to_i
  end
end

puts first
