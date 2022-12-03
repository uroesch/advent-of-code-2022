require 'find'
require 'minitest/autorun'
require_relative '../lib/calories'

class CaloriesTest < Minitest::Test
  INPUT_FILE = 'input-file.test'
  ELFS       = [
    { elf: 1, sum: 6000,  calories: [ 1000, 2000, 3000 ] },
    { elf: 2, sum: 4000,  calories: [ 4000 ] },
    { elf: 3, sum: 11000, calories: [ 5000, 6000 ] },
    { elf: 4, sum: 24000, calories: [ 7000, 8000, 9000 ] },
    { elf: 5, sum: 10000, calories: [ 10000 ] },
  ]

  def calories
    @file     ||= Find.find('../../').select { |x| x.include?(INPUT_FILE) }.first
    @calories ||= Calories.new(@file)
  end

  def test_initialize
    assert_kind_of String, calories.file
    assert_equal calories.file, @file
    assert_kind_of Array, calories.elfs
    assert_equal calories.elfs, []
  end

  def test_parse_file
    calories.parse_file
    assert_kind_of Array, calories.elfs
    assert_equal calories.elfs, ELFS
  end

  def test_most_calories
    assert_kind_of Integer, calories.most_calories
    assert_equal calories.most_calories, 24000
  end

  def test_elf_with_most_calories
    assert_kind_of Integer, calories.elf_with_most_calories
    assert_equal calories.elf_with_most_calories, 4
  end
end
