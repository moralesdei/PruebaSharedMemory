#!usr/bin/env python
# encoding: utf-8

from MultHowKing import mulhowking
from numpy import array, dot, ones, zeros
import time

m1 = ones([1000,1000], dtype=complex)
m2 = ones([1000,1000], dtype=complex)

start = time.time()
res2 = ((dot(m1, m2)).conj())
res = mulhowking(m1, m2)
end = time.time()
print(end-start)
