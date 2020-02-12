#!usr/bin/env python
# encoding: utf-8
# Archivo de lectura de la memoria compartida.

from sysv_ipc import SharedMemory
from numpy import frombuffer, float32
from subprocess import call

shm_key = 0x1234;

# Vinvculamos la memoria compartida a una instancia.
mem = SharedMemory(shm_key)

# Leemos la memoria compartida.
memory_value = mem.read()

# Convertimos la lectura de bytes a numpy array.
y = frombuffer(memory_value, dtype=float32)
print(y)

# Desvinculamos la instancia.
mem.detach()

# Removemos la memoria.
mem.remove()
