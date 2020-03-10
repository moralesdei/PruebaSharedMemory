#!usr/bin/env python
# encoding: utf-8

from MultHowKing import mulhowking
from numpy import array, dot, ones, zeros, random, shape, reshape, round
import time

rm1_r = random.rand(12500, 500)
rm1_i = random.rand(12500, 500)
rm2_r = random.rand(500, 50)
rm2_i = random.rand(500, 50)

m1 = (rm1_r + 1j*rm1_i)
m2 = (rm2_r + 1j*rm2_i)

# m1 = ones([2,5], dtype=complex)
# m2 = ones([5,5], dtype=complex)

#m1 = array([[1+1j,2+2j],[1+1j,1+1j]])
#m2 = array([[1+1j,5+1j],[7+1j,1+1j]])



start_p = time.time()
resultado_python = ((dot(m1, m2)).conj())
end_p = time.time()
print("\nTiempo de ejecucion en python : " + str(end_p-start_p) + "\n")
print(resultado_python)


start_c = time.time()
resultado_c = mulhowking(m1, m2)
end_c = time.time()
print("\nTiempo total de ejecucion opencl + shared memory : " + str(end_c-start_c) + "\n")
print(resultado_c)
