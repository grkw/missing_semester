Debugging

1. `log show --predicate 'process == "sudo"' --info --style syslog --last 1d`
2. Will do the `pdb` tutorial if in the future, I need to use a command-line debugger (rather than the VSCode debugger) someday.
3. Used `shellcheck` and `ale` in vim to fix the issues.
4. Will use reverse debuggers (such as rr for C or RevPDB for Python) if needed in the future. Looks like these work on Apple Silicon even though gdb doesn't?

Profiling

1. `python -m cProfile -s tottime sorts.py`
   These just show the functions

```
1000    0.025    0.000    0.025    0.000 sorts.py:11(insertionsort)
33550/1000    0.022    0.000    0.023    0.000 sorts.py:32(quicksort_inplace)
34058/1000    0.018    0.000    0.030    0.000 sorts.py:23(quicksort)
```

`kernprof -l -v sorts.py` for insertion sort
`-l`: line-by-line profiling
`-v`: immediately display profiling results to the console

```
Wrote profile results to sorts.py.lprof
Timer unit: 1e-06 s

Total time: 0.075305 s
File: sorts.py
Function: insertionsort at line 10

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    10                                           @profile
    11                                           def insertionsort(array):
    12
    13     26830       2093.0      0.1      2.8      for i in range(len(array)):
    14     25830       2390.0      0.1      3.2          j = i-1
    15     25830       2130.0      0.1      2.8          v = array[i]
    16    237076      27881.0      0.1     37.0          while j >= 0 and v < array[j]:
    17    211246      20822.0      0.1     27.7              array[j+1] = array[j]
    18    211246      17154.0      0.1     22.8              j -= 1
    19     25830       2757.0      0.1      3.7          array[j+1] = v
    20      1000         78.0      0.1      0.1      return array
```

The bottleneck is looping through the array.

`kernprof -l -v sorts.py` for quicksort

```
Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    22                                           @profile
    23                                           def quicksort(array):
    24     32922       4144.0      0.1     11.0      if len(array) <= 1:
    25     16961       1165.0      0.1      3.1          return array
    26     15961       1390.0      0.1      3.7      pivot = array[0]
    27     15961      12165.0      0.8     32.3      left = [i for i in array[1:] if i < pivot]
    28     15961      11913.0      0.7     31.6      right = [i for i in array[1:] if i >= pivot]
    29     15961       6920.0      0.4     18.4      return quicksort(left) + [pivot] + quicksort(right)
```

The bottleneck is looking left/right of the pivot.

`python -m memory_profiler sorts.py`

```
Filename: sorts.py

Line #    Mem usage    Increment  Occurrences   Line Contents
=============================================================
    10   52.250 MiB   52.094 MiB        1000   @profile
    11                                         def insertionsort(array):
    12
    13   52.250 MiB    0.000 MiB       25865       for i in range(len(array)):
    14   52.250 MiB    0.000 MiB       24865           j = i-1
    15   52.250 MiB    0.000 MiB       24865           v = array[i]
    16   52.250 MiB    0.016 MiB      229219           while j >= 0 and v < array[j]:
    17   52.250 MiB    0.000 MiB      204354               array[j+1] = array[j]
    18   52.250 MiB    0.047 MiB      204354               j -= 1
    19   52.250 MiB    0.016 MiB       24865           array[j+1] = v
    20   52.250 MiB    0.078 MiB        1000       return array

Filename: sorts.py

Line #    Mem usage    Increment  Occurrences   Line Contents
=============================================================
    22   52.312 MiB   52.266 MiB       35042   @profile
    23                                         def quicksort(array):
    24   52.312 MiB    0.000 MiB       35042       if len(array) <= 1:
    25   52.312 MiB    0.000 MiB       18021           return array
    26   52.312 MiB    0.000 MiB       17021       pivot = array[0]
    27   52.312 MiB    0.016 MiB      165880       left = [i for i in array[1:] if i < pivot]
    28   52.312 MiB    0.016 MiB      165880       right = [i for i in array[1:] if i >= pivot]
    29   52.312 MiB    0.016 MiB       17021       return quicksort(left) + [pivot] + quicksort(right)
```

Nice that it's the same output format as `kernprof`/`line_profiler`. Insertion sort uses less memory than quicksort.

`perf` only exists in Linux, not MacOS.

6. `fib0` was called 21 times. But by memoizing the functions, `fib0` was only called once. Love the call graphs!

7. `lsof`: list open files (includes open sockets for network analysis). It worked!

```
python3.1 31268 gracekwak    4u     IPv6 0xd609e0fc236f3614        0t0                 TCP *:krb524 (LISTEN)
```

```
Serving HTTP on :: port 4444 (http://[::]:4444/) ...
[1]    31268 terminated  python -m http.server 4444
```

8.

```
stress: info: [32125] dispatching hogs: 3 cpu, 0 io, 0 vm, 0 hdd
```

Can't use `taskset` on Mac but alternatives are `cpuset` and `psutil`.
