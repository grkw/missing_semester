#!/bin/bash
./rng.sh > /dev/null # Flush the output
while [[ ! $? -eq 1 ]] # While the exit code of the most recent command is not 1
do
	>&1 echo "Looping" # Print to stdout (>&1 is the default, but it can be included for fun)
	./rng.sh > /dev/null
done
echo "Broke the loop"
