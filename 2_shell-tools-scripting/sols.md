1. `ls --color=auto -lath` (-l=long, -a=all which includes hidden files, -t=sort by modification time, -h=makes the file sizes human-readable, --color=auto: only shows when output is to the user, not piped to another command)
2. See `marco.sh` and `polo.sh`. Variables always exist in the global scope and must be removed using `unset`.
3. See `run_rng.sh` (given code is put in `rng.sh`)
4. `find . -path '*.html' -exec tar -cvf archive.tar {} \+` from `tldr find` (`+` `find`: build the command line by appending each selected file to the end of the argument list, `c`: create, `v`: verbose, `f`: specify filename, `{}`: placeholder for the files found by `find`). Can also use `zip` or `gz`
5. `ls -tr`? -- but we need to list all *files*...
