#!usr/bin/env python
# encoding: utf-8

from MultHowKing import mulhowking
from numpy import array, dot, ones, zeros, random
import time

#rm1_r = random.rand(2, 2)
#rm1_i = random.rand(2, 2)
#rm2_r = random.rand(2, 5)
#rm2_i = random.rand(2, 5)

#m1 = (rm1_r + 1j*rm1_i)
#m2 = (rm2_r + 1j*rm2_i)

m1 = ones([2,2], dtype=complex)
m2 = ones([2,5], dtype=complex)


start_p = time.time()
resultado_python = ((dot(m1, m2)).conj())
end_p = time.time()
print("\nTiempo de ejecucion en python (segundos) : " + str(end_p-start_p) + "\n")
print(resultado_python)

start_c = time.time()
resultado_c = mulhowking(m2, m1)
end_c = time.time()
print("\nTiempo de ejecucion en c (segundos) : " + str(end_c-start_c) + "\n")
print(resultado_c)
