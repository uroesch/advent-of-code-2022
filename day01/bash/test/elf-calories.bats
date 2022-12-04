#!/usr/bin/env bats

@test "elf-calories: with sample input file" {
  export PATH=${BATS_TEST_DIRNAME}/..:${PATH}
  input_file=${BATS_TEST_DIRNAME}/../../input-file.test
  result=$(elf-calories.sh ${input_file}) 
  (( ${result} == 24000 ))
}
