#!/bin/bash
set -euo pipefail

SITE_ROOT="$1"

metadata() {
  sed "s/^$1: //; t; d" "$2" | head -1
}

preprocess() {
  while read md; do
    name=$(basename $(dirname $md))
    date=$(metadata date $md)
    title=$(metadata title $md)
    echo "$name $date $title"
  done
}

postprocess() {
  while read name date title; do
    echo "* [$title]($SITE_ROOT/entries/$name/) <time class=\"entry-date\" datetime=\"$date\">$date</time>"
  done
}

find src/entries -type f -name '*.md' | preprocess | sort -k2r -s | postprocess
