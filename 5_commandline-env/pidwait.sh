 #! /bin/bash
# from https://kamanphoebe.github.io/MIT-missing-semester/Lecture5.html
 pidwait () {
     # `kill -0` gives a nonzero exit status if the process does not exist.
     while kill -0 "$1" 2> /dev/null
     do	
     sleep 1
     done
     ls
 }
