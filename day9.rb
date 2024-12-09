#!/usr/bin/env ruby -w

input = File.open(ARGV[0]).read.chomp.split(//).map(&:to_i)

memory = []

input.each_with_index do |x, i|
  if i.even?
    memory.concat([i / 2] * x)
  else
    memory.concat([nil] * x)
  end
end

left = memory.index(nil)
right = memory.rindex { !_1.nil? }

loop do
  break if left >= right

  memory[left], memory[right] = memory[right], memory[left]

  left += 1 until memory[left].nil? || left >= memory.size
  right -= 1 while memory[right].nil? && right.positive?
end

checksum = memory.each.with_index.reduce(0) do |acc, (v, i)|
  acc += v * i unless v.nil?
  acc
end

puts checksum
