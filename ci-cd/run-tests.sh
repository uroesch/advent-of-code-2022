#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

declare -r SCRIPT=${0##*/}
declare -r ROOT_DIR=$(cd $(dirname ${0})/..; pwd)
declare -g DEPENDENCIES=

function usage() {
  local exit_code=${1:-1}
  cat << USAGE

  Usage:
    ${SCRIPT} [<options>]

  Options:
    -D | --install-dependencies  Install dependencies before running test
    -h | --help                  This message

USAGE
  exit ${exit_code}
}

function parse_options() {
  while (( ${#} > 0 )); do
    case ${1} in
    -D|--install-dependencies) DEPENDENCIES=true;;
    -h|--help) usage 0;;
    -*) usage 1;;
    esac
    shift
  done
}

function find_test_files() {
  find ${ROOT_DIR} \
    -type f \
    -name "[RM]akefile"
}

function title() {
  local -r dir=${1}; shift;
  IFS=/ read -a title  <<< ${dir}
  local language=${title[-1]}
  local day=${title[-2]}
  
  printf "\n\n%s %d - %s\n" Day ${day//[^0-9]/} ${language^}
  printf "%-0.1s" -{0..80} $'\n'
}

function run_tests() {
  for file in $(find_test_files); do
    case ${file} in
    */Rakefile) cmd=rake;;
    */Makefile) cmd=make;;
    esac

    dir=$(dirname ${file})
    cd ${dir}
    title ${dir}
    ${DEPENDENCIES:+${cmd} dependencies}
    ${cmd} test
  done 
}

parse_options "${@}"
run_tests
