#!/usr/bin/env ruby -w

first = 0

operators = ['+', '*']

File.open(ARGV[0]).readlines.each do |line|
  /^(?<result>\d+):\s+(?<params>.*)$/ =~ line.chomp

  result = result.to_i
  operands = params.split.map(&:to_i)

  first += result if operators.repeated_permutation(operands.size - 1).any? do |ops|
    s = operands[1..].reduce(operands[0]) do |k, v|
      if ops.shift == '*'
        k * v
      else
        k + v
      end
    end

    s == result
  end
end

puts first
