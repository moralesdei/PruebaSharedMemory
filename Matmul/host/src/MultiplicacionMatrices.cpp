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
#include <assert.h>
#include <cstring>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <string.h>
#include <time.h>
#include "CL/opencl.h"
#include "AOCL_Utils.h"

using namespace aocl_utils;

#define SHM_KEY_M1R 0x1234
#define SHM_KEY_M1I 0x2345
#define SHM_KEY_M2R 0x3456
#define SHM_KEY_M2I 0x4567
#define SHM_KEY_RER 0x5678
#define SHM_KEY_REI 0x6789

// OpenCL runtime configuration
static cl_platform_id platform = NULL;
static cl_device_id device = NULL;
static cl_context context = NULL;
static cl_command_queue queue = NULL;
static cl_kernel kernel = NULL;
static cl_program program = NULL;
static cl_mem buff_m1r, buff_m1i, buff_m2r, buff_m2i, buff_rer, buff_rei;
static void *m1rH, *m1iH, *m2rH, *m2iH, *rerH, *reiH;

bool init();
void cleanup();

int main(int argc, char *argv[]){

	cl_int status;

	if(!init()){
			return -1;
	}

	const size_t fil_m1 = atoi(argv[1]);
	const size_t col_m2 = atoi(argv[2]);
	const size_t c1f2 = atoi(argv[3]);

	int shmid_m1r,shmid_m2r, shmid_m1i, shmid_m2i, shmid_rer, shmid_rei;

	shmid_m1i = shmget(SHM_KEY_M1R, sizeof(float)*fil_m1*c1f2, 0644|IPC_CREAT);
	shmid_m1r = shmget(SHM_KEY_M1I, sizeof(float)*fil_m1*c1f2, 0644|IPC_CREAT);
	shmid_m2i = shmget(SHM_KEY_M2R, sizeof(float)*c1f2*col_m2, 0644|IPC_CREAT);
	shmid_m2r = shmget(SHM_KEY_M2I, sizeof(float)*c1f2*col_m2, 0644|IPC_CREAT);
	shmid_rer = shmget(SHM_KEY_RER, sizeof(float)*fil_m1*col_m2, 0644|IPC_CREAT);
	shmid_rei = shmget(SHM_KEY_REI, sizeof(float)*fil_m1*col_m2, 0644|IPC_CREAT);


	m1rH = shmat(shmid_m1r, NULL, 0);
	m1iH = shmat(shmid_m1i, NULL, 0);
	m2rH = shmat(shmid_m2r, NULL, 0);
	m2iH = shmat(shmid_m2i, NULL, 0);
	rerH = shmat(shmid_rer, NULL, 0);
	reiH = shmat(shmid_rei, NULL, 0);

	// Create buffers
	buff_m1r = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_COPY_HOST_PTR, sizeof(float) * fil_m1 * c1f2, m1rH, &status);
	checkError(status, "Failed to create buffer");
	buff_m1i = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_COPY_HOST_PTR, sizeof(float) * fil_m1 * c1f2, m1iH, &status);
	checkError(status, "Failed to create buffer");
	buff_m2r = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_COPY_HOST_PTR, sizeof(float) * c1f2 * col_m2, m2rH, &status);
	checkError(status, "Failed to create buffer");
	buff_m2i = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_COPY_HOST_PTR, sizeof(float) * c1f2 * col_m2, m2iH, &status);
	checkError(status, "Failed to create buffer");
	buff_rer = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(float) * fil_m1 * col_m2, NULL, &status);
	checkError(status, "Failed to create buffer");
	buff_rei = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(float) * fil_m1 * col_m2, NULL, &status);
	checkError(status, "Failed to create buffer");

	// Set kernel arguments
	status = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&buff_m1r);
	checkError(status, "Failed to set kernel arg 0");
	status = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void*)&buff_m1i);
	checkError(status, "Failed to set kernel arg 1");
	status = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&buff_m2r);
	checkError(status, "Failed to set kernel arg 2");
	status = clSetKernelArg(kernel, 3, sizeof(cl_mem), (void*)&buff_m2i);
	checkError(status, "Failed to set kernel arg 3");
	status = clSetKernelArg(kernel, 4, sizeof(cl_mem), (void*)&buff_rer);
	checkError(status, "Failed to set kernel arg 4");
	status = clSetKernelArg(kernel, 5, sizeof(cl_mem), (void*)&buff_rei);
	checkError(status, "Failed to set kernel arg 5");
	status = clSetKernelArg(kernel, 6, sizeof(cl_mem), (void*)&c1f2);
	checkError(status, "Failed to set kernel arg 6");
	status = clSetKernelArg(kernel, 7, sizeof(cl_mem), (void*)&col_m2);
	checkError(status, "Failed to set kernel arg 7");

	// Configure work set over which the kernel will execute
	size_t gSize[2] = {fil_m1, col_m2};

	// Launch the kernel
	status = clEnqueueNDRangeKernel(queue, kernel, 2, NULL, gSize, gSize, 0, NULL, NULL);
	checkError(status, "Failed to launch kernel");

	// Read buffer output
	status = clEnqueueReadBuffer(queue, buff_rer, CL_TRUE, 0, sizeof(float) * fil_m1 * col_m2, rerH, 0, NULL, NULL);
	checkError(status, "Failed to read buffer");
	status = clEnqueueReadBuffer(queue, buff_rei, CL_TRUE, 0, sizeof(float) * fil_m1 * col_m2, reiH, 0, NULL, NULL);
	checkError(status, "Failed to read buffer");

  cleanup();

	shmdt(rerH);
	shmdt(reiH);
	shmdt(m1rH);
	shmdt(m1iH);
	shmdt(m2rH);
	shmdt(m2rH);

	shmctl(shmid_m1i, IPC_RMID, 0);
	shmctl(shmid_m1r, IPC_RMID, 0);
	shmctl(shmid_m2i, IPC_RMID, 0);
	shmctl(shmid_m2r, IPC_RMID, 0);

	return 0;

}

void cleanup() {

	if(buff_m1r) {
		clEnqueueUnmapMemObject(queue, buff_m1r, m1rH, 0, NULL, NULL);
		clReleaseMemObject(buff_m1r);
	}
	if(buff_m1i) {
		clEnqueueUnmapMemObject(queue, buff_m1i, m1iH, 0, NULL, NULL);
		clReleaseMemObject(buff_m1i);
	}
  if(buff_m2r) {
		clEnqueueUnmapMemObject(queue, buff_m2r, m2rH, 0, NULL, NULL);
		clReleaseMemObject(buff_m2r);
	}
if(buff_m2i) {
		clEnqueueUnmapMemObject(queue, buff_m2i, m2iH, 0, NULL, NULL);
		clReleaseMemObject(buff_m2i);
	}
	if(buff_rer) {
		clEnqueueUnmapMemObject(queue, buff_rer, rerH, 0, NULL, NULL);
		clReleaseMemObject(buff_rer);
	}
	if(buff_rei) {
		clEnqueueUnmapMemObject(queue, buff_rei, reiH, 0, NULL, NULL);
		clReleaseMemObject(buff_rei);
	}
	if(kernel) {
		clReleaseKernel(kernel);
	}
	if(program) {
		clReleaseProgram(program);
	}
	if(queue) {
		clReleaseCommandQueue(queue);
	}
	if(context) {
		clReleaseContext(context);
	}
}

bool init() {
	cl_int status;
	platform = findPlatform("Altera");

	if(platform == NULL) {
		printf("ERROR: Unable to find Altera OpenCL platform.\n");
		return false;
	}

	scoped_array<cl_device_id> devices;
	cl_uint num_devices;

	devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

	// We'll just use the first device.
	device = devices[0];

	// Create the context.
	context = clCreateContext(NULL, 1, &device, NULL, NULL, &status);
	checkError(status, "Failed to create context");

	// Create the command queue.
	queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
	checkError(status, "Failed to create command queue");

	// Create the program.
	std::string binary_file = getBoardBinaryFile("mult", device);
	//printf("Using AOCX: %s\n", binary_file.c_str());
	program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);

	// Build the program that was just created.
	status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
	checkError(status, "Failed to build program");

	// Create the kernel - name passed in here must match kernel name in the
	// original CL file, that was compiled into an AOCX file using the AOC tool
	const char *kernel_name = "Matmul";  // Kernel name, as defined in the CL file
	kernel = clCreateKernel(program, kernel_name, &status);
	checkError(status, "Failed to create kernel");

	return true;
}
