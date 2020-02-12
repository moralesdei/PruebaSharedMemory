#!usr/bin/env python
# encoding: utf-8

from subprocess import call

a = 10;
b = 25;

call(["./a.out", str(a), str(b)])
