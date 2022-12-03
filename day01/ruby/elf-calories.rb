#!/usr/bin/env ruby

require_relative 'lib/calories'

file = '../input-file'


# Library wit tests
elfs = Calories.new(file)
elfs.parse_file
elfs.print_rank
puts elfs.elf_with_most_calories
puts elfs.most_calories


# Compact
res = File.open(file).readlines("\n\n", chomp: true).each.inject(cal: -1) do |res, cal|
  sum = cal.split("\n").map(&:to_i).sum
  res = { cal: sum } if res[:cal] < sum
  res
end
puts "%{cal}" % res
