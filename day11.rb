#!/usr/bin/env ruby -w

input = File.open(ARGV[0]).read.split(/\s+/).map(&:to_i)

25.times do
  tmp = []

  input.each do |n|
    if n.zero?
      tmp << 1
    else
      d = n.to_s

      if d.size.even?
        tmp << d[...d.size / 2].to_i
        tmp << d[d.size / 2..].to_i
      else
        tmp << n * 2024
      end
    end
  end

  input = tmp
end

puts input.size
