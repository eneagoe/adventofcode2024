#!/usr/bin/env ruby -w

g = Hash.new { |hash, key| hash[key] = [] }
first = 0
second = 0
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

    if valid
      first += pages[pages.size / 2]
      next
    end

    # put the pages in the right order
    current = []

    (0...pages.size).each do |i|
      if !pages[..i].intersect?(g[pages[i]])
        current << pages[i]
      else
        j = current.size
        # insert into right position
        j -= 1 while current[...j].intersect?(g[pages[i]])
        current.insert(j, pages[i])
      end
    end

    second += current[current.size / 2]
  end
end

puts first
puts second
