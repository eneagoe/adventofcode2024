#!/usr/bin/env ruby -w

g = Hash.new { |hash, key| hash[key] = [] }
first = 0
building = true

File.open(ARGV[0]).readlines.each do |line|
  line.chomp!

  if line.empty?
    building = false
    next
  end

  if building
    /(?<a>\d+)\|(?<b>\d+)/ =~ line

    g[a.to_i] << b.to_i
  else
    pages = line.split(',').map(&:to_i)

    valid = (0...pages.size).all? { |i| !pages[..i].intersect?(g[pages[i]]) }

    first += pages[pages.size / 2] if valid
  end
end

puts first
