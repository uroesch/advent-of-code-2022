# -----------------------------------------------------------------------------
# Advent of Code 2022 - Day 1
# -----------------------------------------------------------------------------
class Calories

  attr_reader :file, :elfs

  def initialize(input_file)
    @file = input_file
    @elfs = []
  end

  def parse_file
    return if @elfs.count > 0
    begin
      elf = 0
      fh = File.new(@file)
      @elfs = fh.readlines("\n\n", chomp: true).map do |cal|
        calories = cal.split("\n").map(&:to_i)
        { elf: elf += 1, sum: calories.sum, calories: calories }
      end
    rescue => e
      fail e.message
    end
  end
  
  def elf_with_most_calories
    top_elf[:elf]
  end

  def most_calories
    top_elf[:sum]
  end

  

  def print_rank
    parse_file
    @elfs.sort { |a, b| a[:sum] <=> b[:sum] }.each do |data|
      puts "elf: %4{elf}   calories: %7{sum}\n" % data 
    end
  end

  private

  def top_elf
    parse_file
    top = @elfs.inject(elf: -1, sum: -1) do |res, data|
      res = { elf: data[:elf], sum: data[:sum] } if res[:sum] < data[:sum]
      res
    end 
  end
end
