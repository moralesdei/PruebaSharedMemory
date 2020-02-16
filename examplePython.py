#!usr/bin/env python
# encoding: utf-8

from MultHowKing import mulhowking
from numpy import array, dot, ones, zeros
import time

m1 = ones([1000,1000], dtype=complex)
m2 = ones([1000,1000], dtype=complex)

start = time.time()
res = mulhowking(m1, m2)
end = time.time()

start1 = time.time()
res2 = ((dot(m1, m2)).conj())
end1 = time.time()

print("imprimiendo en c ")
print(res)
print("tiempo : " + str(end-start))

print("imprimiendo en python")
print(res2)
print("tiempo : " + str(end1-start1))
