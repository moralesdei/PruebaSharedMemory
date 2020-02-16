#!usr/bin/env python
# encoding: utf-8
import sysv_ipc
from numpy import frombuffer, float32, array, dot, shape
from subprocess import call
import time
def mulhowking(m1, m2):

    # Declaracion de los ids necesarios para la memoria.

    shm_key_m1r = 0x1234;
    shm_key_m1i = 0x2345;
    shm_key_m2r = 0x3456;
    shm_key_m2i = 0x4567;
    shm_key_rer = 0x5678;
    shm_key_rei = 0x6789;

    m1r = array(m1.real, dtype=float32)
    m1i = array(m1.imag, dtype=float32)
    m2r = array(m2.real, dtype=float32)
    m2i = array(m2.imag, dtype=float32)

    mem_m1r = sysv_ipc.SharedMemory(0x1234, sysv_ipc.IPC_CREAT, size=m1r.nbytes)
    mem_m1i = sysv_ipc.SharedMemory(0x2345, sysv_ipc.IPC_CREAT, size=m1i.nbytes)
    mem_m2r = sysv_ipc.SharedMemory(0x3456, sysv_ipc.IPC_CREAT, size=m2r.nbytes)
    mem_m2i = sysv_ipc.SharedMemory(0x4567, sysv_ipc.IPC_CREAT, size=m2i.nbytes)

    mem_m1r.write((m1r.tobytes()))
    mem_m1i.write((m1i.tobytes()))
    mem_m2r.write((m2r.tobytes()))
    mem_m2i.write((m2i.tobytes()))

    mem_m1r.detach()
    mem_m1i.detach()
    mem_m2r.detach()
    mem_m2i.detach()

    start = time.time()
    call(["./main.out", str(shape(m1r)[0]), str(shape(m2r)[1]), str(shape(m1r)[1])])
    end = time.time()

    mem_rer = sysv_ipc.SharedMemory(shm_key_rer)
    mem_rei = sysv_ipc.SharedMemory(shm_key_rei)

    resultado_real = mem_rer.read()
    resultado_imag = mem_rei.read()

    mem_rer.detach()
    mem_rei.detach()
    mem_rer.remove()
    mem_rei.remove()

    resr = frombuffer(resultado_real, dtype=float32)
    resi = frombuffer(resultado_imag, dtype=float32)

    resultado = (resr + 1j*resi).reshape([shape(m1r)[0],shape(m2r)[1]])

    return resultado
