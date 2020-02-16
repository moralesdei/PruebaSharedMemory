// Multiplicacion de matrices, Este programa multiplica dos matrices complejas
// Copyright (C) 2020 moralesdei
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <string.h>
#include <time.h>

#define SHM_KEY_M1R 0x1234
#define SHM_KEY_M1I 0x2345
#define SHM_KEY_M2R 0x3456
#define SHM_KEY_M2I 0x4567
#define SHM_KEY_RER 0x5678
#define SHM_KEY_REI 0x6789

void main(int argc, char *argv[])
{

  int fil_m1 = atoi(argv[1]);
	int col_m2 = atoi(argv[2]);
	int c1f2 = atoi(argv[3]);

	int i, j, shmid_m1r,shmid_m2r, shmid_m1i, shmid_m2i, shmid_rer, shmid_rei;
	float resultado_imag[fil_m1][col_m2], resultado_real[fil_m1][col_m2];
	float *m1r, *m1i, *m2r, *m2i, *rer, *rei;

	shmid_m1i = shmget(SHM_KEY_M1R, sizeof(float)*fil_m1*c1f2, 0644|IPC_CREAT);
	shmid_m1r = shmget(SHM_KEY_M1I, sizeof(float)*fil_m1*c1f2, 0644|IPC_CREAT);
	shmid_m2i = shmget(SHM_KEY_M2R, sizeof(float)*c1f2*col_m2, 0644|IPC_CREAT);
	shmid_m2r = shmget(SHM_KEY_M2I, sizeof(float)*c1f2*col_m2, 0644|IPC_CREAT);
	shmid_rer = shmget(SHM_KEY_RER, sizeof(float)*fil_m1*col_m2, 0644|IPC_CREAT);
	shmid_rei = shmget(SHM_KEY_REI, sizeof(float)*fil_m1*col_m2, 0644|IPC_CREAT);


	m1r = shmat(shmid_m1r, NULL, 0);
	m1i = shmat(shmid_m1i, NULL, 0);
	m2r = shmat(shmid_m2r, NULL, 0);
	m2i = shmat(shmid_m2i, NULL, 0);
	rer = shmat(shmid_rer, NULL, 0);
	rei = shmat(shmid_rei, NULL, 0);

  clock_t start = clock();
	for(i=0;i<fil_m1;i++)
		{
			for(j=0;j<col_m2;j++)
				{
					resultado_real[i][j] = 0.0;
					resultado_imag[i][j] = 0.0;
					for(int n=0;n<c1f2;n++)
						{
							resultado_real[i][j] += (*(m1r+i*c1f2+n) * *(m2r+n*col_m2+j)) - (*(m1i+i*c1f2+n) * *(m2i+n*col_m2+j));
							resultado_imag[i][j] += (*(m1r+i*c1f2+n) * *(m2i+n*col_m2+j)) + (*(m1i+i*c1f2+n) * *(m2r+n*col_m2+j));
						}
					resultado_imag[i][j] *= -1;
          resultado_real[i][j] *= -1;

				}
		}
    printf("Tiempo transcurrido: %f \n", ((double)clock() - start) / CLOCKS_PER_SEC);

	memcpy(rer, resultado_real, sizeof(resultado_real));
	memcpy(rei, resultado_imag, sizeof(resultado_imag));

	shmdt(m1r);
	shmdt(m1i);
	shmdt(m2r);
	shmdt(m2r);
	shmdt(rer);
	shmdt(rei);
	shmctl(shmid_m1i, IPC_RMID, 0);
	shmctl(shmid_m1r, IPC_RMID, 0);
	shmctl(shmid_m2i, IPC_RMID, 0);
	shmctl(shmid_m2r, IPC_RMID, 0);

}
