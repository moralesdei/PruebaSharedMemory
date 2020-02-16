#!usr/bin/env python
# encoding: utf-8
# Archivo de escritura de la memoria compartida.

import sysv_ipc
import sys
from numpy import frombuffer, float32, array
from subprocess import call

shm_key = 0x1234;

a = array([1.5, 2.2], dtype=float32)
# Vinvculamos la memoria compartida a una instancia.
mem = sysv_ipc.SharedMemory(0x1234, sysv_ipc.IPC_CREX, size=a.nbytes)

conv = a.tobytes()

mem.write(conv)
mem.detach()
