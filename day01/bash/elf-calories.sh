#!/usr/bin/bash

set -o errexit
set -o nounset
set -o pipefail

declare -r FILE=${1:-../input-file.test}
declare -i CALORIES=0

function calculate_calories() {
  local -r file=${1};
  local -i sum=0
  while IFS=$'\n' read line; do
    case "${line}" in
    [0-9]*) (( sum += line ));;
    '')     (( ${CALORIES} < ${sum} )) && CALORIES=${sum}; sum=0;;
    esac
  done < ${file}
} 

calculate_calories "${FILE}"
echo ${CALORIES}
