#!/usr/bin/env ruby -w

# this will be much slower than the first part, but the algorithm is the same
second = 0

operators = ['+', '*', '||']

File.open(ARGV[0]).readlines.each do |line|
  /^(?<result>\d+):\s+(?<params>.*)$/ =~ line.chomp

  result = result.to_i
  operands = params.split.map(&:to_i)

  second += result if operators.repeated_permutation(operands.size - 1).any? do |ops|
    s = operands[1..].reduce(operands[0]) do |k, v|
      operator = ops.shift

      if operator == '*'
        k * v
      elsif operator == '||'
        (k.to_s + v.to_s).to_i
      else
        k + v
      end
    end

    s == result
  end
end

puts second
