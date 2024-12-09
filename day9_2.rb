#!/usr/bin/env ruby -w

input = File.open(ARGV[0]).read.chomp.split(//).map(&:to_i)

memory = []
files = []
free = []

idx = 0
input.each_with_index do |x, i|
  if i.even?
    files << [i / 2, x, idx]
    memory.concat([i / 2] * x)
  else
    free << [idx, x]
    memory.concat([nil] * x)
  end
  idx += x
end

files.reverse.each do |(fid, size, start)|
  at = free.index  { |(_idx, cap)| cap >= size }

  next if at.nil? # no space big enough

  idx, cap = free[at]
  next if idx >= start # not to the left

  memory[idx...idx + size] = [fid] * size
  memory[start...start + size] = [nil] * size

  if cap == size
    free.delete_at(at)
  else
    free[at] = [idx + size, cap - size]
  end
end

checksum = memory.each.with_index.reduce(0) do |acc, (v, i)|
  acc += v * i unless v.nil?
  acc
end

puts checksum
