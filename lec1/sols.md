1. `echo $SHELL` ->  `/bin/zsh`
2. `mkdir /tmp/missing`
3. `touch`: created files and set access/modification times
4. `touch semester`
5. `echo '#!/bin/sh' >> semester` `echo 'curl --head --silent https://missing.csail.mit.edu' >> semester`, use single quotes for literal strings
6. `./semester` -> `zsh: permission denied: ./semester`. `ls -l semester` -> `-rw-r--r--@ 1 gracekwak  staff  61 Nov 19 10:18 semester`
7. `sh semester` runs the script as super-user
8. `tldr chmod`: Change the access permissions of a file or directory
9. `chmod +x semester`: This gives execute permissions to the user, group and others
10. `tldr grep`: Find patterns in files using regular expressions. `./semester | grep 'last-modified' > last-modified.txt`
