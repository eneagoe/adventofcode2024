#!/usr/bin/env ruby -w

cnt = Hash.new(0)
File.open(ARGV[0]).read.split(/\s+/).map(&:to_i).each { |n| cnt[n] += 1 }

# this time simulating the process won't work, the input becomes huge
# a DP approach is better

75.times do
  newcnt = Hash.new(0)

  cnt.each do |n, v|
    if n.zero?
      newcnt[1] += v
    else
      d = n.to_s

      if d.size.even?
        a = d[...d.size / 2].to_i
        b = d[d.size / 2..].to_i

        newcnt[a] += v
        newcnt[b] += v
      else
        newcnt[n * 2024] += v
      end
    end
  end

  cnt = newcnt
end

puts cnt.each_value.sum
