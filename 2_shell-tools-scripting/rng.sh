#!/usr/bin/env bash

 n=$(( RANDOM % 100 ))

 if [[ n -eq 42 ]]; then
    echo "Something went wrong"
    >&2 echo "The error was using magic numbers" # Writes to stderr (gets a reference &, and 2 is stderr)
    exit 1
 fi

 echo "Everything went according to plan"
