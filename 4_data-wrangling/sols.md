1. Took the regex tutorial.
2. `cat /usr/share/dict/words | tr "[:upper:]" "[:lower:]" | grep ".*a.*a.*a.*" | grep "[^('s)]$" | wc -l`

- `tr`: translate tool
- `[]` represents a character class in regex
- `grep` stands for Global Regular Expression Print! Originally a command sequence used in `ed`: `g/re/p`

Did some `sort`, `uniq -c`, `tail -n3`, `awk '{ print $1 }'` but didn't save the command 😭

3. ~~This is a bad idea because you're editing a file while saving to it, so you risk corruption or partial content.~~ Apparently "sed s/REGEX/SUBSTITUTION/ input.txt > input.txt will return a blank file, since input.txt on the right hand side of the output operator > will be made blank _before_ the left hand side of the output operator could be applied. Because the file names conicide, an empty input.txt will be output to an empty input.txt." This is not particular to sed. You can use `sed -I` to edit files in-place while saving backups. You can use `sed -i` to edit files in-place but treating each file independently from other files.
4. `log show | grep 'system boot' | head` taking a really long time and only showing a few results...
5. Skipped since not using Linux.
6. This looks like pain. I'm happy officially knowing that `curl` (and `wget`) are command-line tools that can access files from FTP, HTTP, and HTTPS.
   But I like this solution I found [here](https://kamanphoebe.github.io/MIT-missing-semester/Lecture4.html):

```
# find the max of one column in a single command
 curl https://ucr.fbi.gov/crime-in-the-u.s/2016/crime-in-the-u.s.-2016/topic-pages/tables/table-1 | pup 'td[class="odd group1 alignright valignmentbottom numbercell"]' | sed -E 's/^<.*>$//' | sort | sed -E 's/ ([0-9]+),([0-9]+),([0-9]+)/\1\2\3/' | grep -v '^$' | tail -n 1

 # calculate the sum of one column
 curl https://ucr.fbi.gov/crime-in-the-u.s/2016/crime-in-the-u.s.-2016/topic-pages/tables/table-1 | pup 'td[class="odd group1 alignright valignmentbottom numbercell"]' | sed -E 's/^<.*>$//' | sort | sed -E 's/ ([0-9]+),([0-9]+),([0-9]+)/\1\2\3/' | grep -v '^$' | paste -sd+ | bc
```

`curl https://ucr.fbi.gov/.../table-1`: This command uses `curl` to download the HTML content of the specified URL. In this case, it fetches a specific page from the FBI's Uniform Crime Reporting section concerning crime in the U.S. for 2016.

`pup 'td[class="odd group1 alignright valignmentbottom numbercell"]'`: This command uses `pup`, an HTML parsing tool, to filter and select only the table data (`<td>`) elements with a specific class attribute from the HTML data fetched by `curl`. The class specified targets cells that are presumably formatted in a particular way based on the page's HTML structure.

`sed -E 's/^<.*>$//'`: The `sed` command with extended regex (`-E`) is used here to remove any remaining HTML tags from the lines that might have passed through. The pattern `^<.*>$` matches any line that starts and ends with HTML content and substitutes it with an empty string (essentially cleaning up the extracted data).

`sort`: The `sort` command sorts the lines of text, which could be numbers in this case. It's important to note that if these should be numeric sorts due to numeric content in cells, additional options might be desired. Without options, it performs a lexicographical sort.

`sed -E 's/ ([0-9]+),([0-9]+),([0-9]+)/\1\2\3/'`: This command uses `sed` to remove commas from the numbers, possibly to make them easier to sort or perform numeric operations later. It matches numbers that are delimited by commas and removes those commas (e.g., it transforms "1,234" to "1234").

`grep -v '^$'`: This filters out any empty lines from the output, producing only the non-empty number lines.

`tail -n 1`: This final command takes the last line of the current output, likely to find the largest or last entry in the sorted list (after transformation and filtering).

`paste -sd+ | bc` is a combination of two commands that are commonly used together to sum a list of numbers
The command `paste -sd+ | bc` is a combination of two commands that are commonly used together to sum a list of numbers. Here's how each part works:

`paste -sd+`: The `paste` command is used to combine lines of files horizontally. The `-s` option tells `paste` to serialize the input, meaning it will treat all lines of input as one long line. The `-d+` option specifies the '+' character as the delimiter to insert between these lines. Therefore, if you have a list of numbers, `paste -sd+` will join them into a single line, separated by `+`. For example, if you have the input lines:
1
2
3
This would produce:
1+2+3
`| bc`: The `bc` command is a calculator that can process mathematical expressions. When piped from `paste -sd+`, it takes the resulting string (like `1+2+3`) and computes the expression, outputting the sum of the numbers. "Basic Calculator"

Together, these commands transform a multiline list of numbers into a single sum. If your input is a file or lines of numbers that you want to sum up, you can use this pipeline to achieve that.

Notes to self:

`cat`: Concatenates and prints files to the standard output.
`more`: Pages through a file instead of printing to the screen all at once.
`less`: Similar to `more`, but provides more navigation capabilities.
`head`: Outputs the first part of files (by default, the first 10 lines).
`tail`: Outputs the last part of files (by default, the last 10 lines).
