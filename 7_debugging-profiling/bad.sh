#!/bin/sh
## Example: a typical script with several problems
for f in *.m3u*;
do
  grep -qi 'hq.*mp3' "$f" \
    && echo "Playlist $f contains a HQ file in mp3 format" 
# -q: quiet mode
# -i case-insensitive matching
# \: escape character that allows you to continue a command on the next line. If the `grep` command succeeds, the script will execute the `echo` command.
done
