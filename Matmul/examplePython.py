#!usr/bin/env python
# encoding: utf-8

from MultHowKing import mulhowking
from numpy import array, dot, ones, zeros
import time

m1 = ones([12500,500], dtype=complex)
m2 = ones([500,500], dtype=complex)

start_p = time.time()
resultado_python = ((dot(m1, m2)).conj())
end_p = time.time()
print("\nTiempo de ejecucion en python (segundos) : " + str(end_p-start_p) + "\n")
print(resultado_python)

start_c = time.time()
resultado_c = mulhowking(m1, m2)
end_c = time.time()
print("\nTiempo de ejecucion en c (segundos) : " + str(end_c-start_c) + "\n")
print(resultado_c)
