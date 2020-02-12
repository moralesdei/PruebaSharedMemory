// Archivo de escritura en la memoria compartida.

#include <stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>

#define SHM_KEY 0x1234

int main(int argc, char *argv[]){

  // Declaracion de las variables necesarias.
  int shmid;
  //float *shmp, numeros[] = {5.1, 2.2, 5.7, 6.8, 7.9};
  float *shmp, numeros[2][2] = {{1.5,2.2},{3.3,4.4}}; 

  // Creacion del segmento de memoria compartida.
  shmid = shmget(SHM_KEY, sizeof(numeros), 0644|IPC_CREAT);

  if(shmid == -1)
    {
      perror("Shared memory");
      return 1;
    }

  // Vinculamos la memoria compartida a un puntero.
  shmp = shmat(shmid, NULL, 0);

  if(shmp == (void *) -1)
    {
      perror("Shared memory attach");
      return 1;
    }

  // Cargamos la memoria con la informacion requerida.
  memcpy(shmp, &numeros, sizeof(numeros));

  if (shmdt(shmp) == -1)
    {
      perror("shmdt");
      return 1;
    }

    printf("Writing Process: Complete\n");
    return 0;
}
