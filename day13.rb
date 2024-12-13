#!/usr/bin/env ruby -w

require 'matrix'

first = 0
second = 0

File.open(ARGV[0]).readlines.map(&:chomp).each_slice(4) do |(claw_a, claw_b, prize, _)|
  /Button\s+A:\s+X\+(?<a>\d+),\s+Y\+(?<b>\d+)/ =~ claw_a
  /Button\s+B:\s+X\+(?<d>\d+),\s+Y\+(?<e>\d+)/ =~ claw_b
  /Prize:\s+X=(?<c>\d+),\s+Y=(?<f>\d+)/ =~ prize

  m = Matrix[[a.to_i, d.to_i], [b.to_i, e.to_i]]
  v = Matrix[[c.to_i], [f.to_i]]
  v2 = Matrix[[c.to_i + 10_000_000_000_000], [f.to_i + 10_000_000_000_000]]

  next if m.determinant.zero?

  x = m.inv * v

  first += (x[0, 0] * 3 + x[1, 0]).to_i if x[0, 0].denominator == 1 && x[1, 0].denominator == 1

  x2 = m.inv * v2

  second += (x2[0, 0] * 3 + x2[1, 0]).to_i if x2[0, 0].denominator == 1 && x2[1, 0].denominator == 1
end

puts first
puts second
