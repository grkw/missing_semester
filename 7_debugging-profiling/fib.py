#!/usr/bin/env python
def fib0(): return 0

def fib1(): return 1

s = """def fib{}(): return fib{}() + fib{}()""" # template string for function definitions

if __name__ == '__main__':

    for n in range(2, 10):
        exec(s.format(n, n-1, n-2)) # dynamic function generation
    # from functools import lru_cache # store previously computed results in cache
    # for n in range(10):
    #     exec("fib{} = lru_cache(1)(fib{})".format(n, n))
    print(eval("fib9()"))
