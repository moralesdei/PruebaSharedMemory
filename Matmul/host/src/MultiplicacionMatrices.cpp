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
static cl_mem kernelm1r, kernelm1i, kernelm2r, kernelm2i, kernelrer, kernelrei;

// input and output vectors
static void *m1r, *m1i, *m2r, *m2i, *rer, *rei;
bool init();
void cleanup();

int main(int argc, char *argv[])
{
	
	cl_int status;
  if(!init())
  {
    return -1;
  }

  static const size_t fil_m1 = atoi(argv[1]);
	static const size_t col_m2 = atoi(argv[2]);
	static const size_t c1f2 = atoi(argv[3]);

	int i, j, n, shmid_m1r,shmid_m2r, shmid_m1i, shmid_m2i, shmid_rer, shmid_rei;
	void *ma1r, *ma1i, *ma2r, *ma2i, *arer, *arei;

	shmid_m1i = shmget(SHM_KEY_M1R, sizeof(float)*fil_m1*c1f2, 0644|IPC_CREAT);
	shmid_m1r = shmget(SHM_KEY_M1I, sizeof(float)*fil_m1*c1f2, 0644|IPC_CREAT);
	shmid_m2i = shmget(SHM_KEY_M2R, sizeof(float)*c1f2*col_m2, 0644|IPC_CREAT);
	shmid_m2r = shmget(SHM_KEY_M2I, sizeof(float)*c1f2*col_m2, 0644|IPC_CREAT);

	ma1r = shmat(shmid_m1r, NULL, 0);
	ma1i = shmat(shmid_m1i, NULL, 0);
	ma2r = shmat(shmid_m2r, NULL, 0);
	ma2i = shmat(shmid_m2i, NULL, 0);

  // Create buffers.
  kernelm1r = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR, sizeof(cl_float) * fil_m1 * c1f2, NULL, &status);
  checkError(status, "Failed to create buffer");
  kernelm1i = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR, sizeof(cl_float) * fil_m1 * c1f2, NULL, &status);
  checkError(status, "Failed to create buffer");
  kernelm2r = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR, sizeof(cl_float) * c1f2 * col_m2, NULL, &status);
  checkError(status, "Failed to create buffer");
  kernelm2i = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR, sizeof(cl_float) * c1f2 * col_m2, NULL, &status);
  checkError(status, "Failed to create buffer");
  kernelrer = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR, sizeof(cl_float) * fil_m1 * col_m2, NULL, &status);
  checkError(status, "Failed to create buffer");
  kernelrei = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR, sizeof(cl_float) * fil_m1 * col_m2, NULL, &status);
  checkError(status, "Failed to create buffer");
  
  m1r = clEnqueueMapBuffer(queue, kernelm1r, CL_TRUE, CL_MAP_WRITE|CL_MAP_READ, 0, sizeof(cl_float) * fil_m1 * c1f2, 0, NULL, NULL, NULL);
  m1i = clEnqueueMapBuffer(queue, kernelm1i, CL_TRUE, CL_MAP_WRITE|CL_MAP_READ, 0, sizeof(cl_float) * fil_m1 * c1f2, 0, NULL, NULL, NULL);
  m2r = clEnqueueMapBuffer(queue, kernelm2r, CL_TRUE, CL_MAP_WRITE|CL_MAP_READ, 0, sizeof(cl_float) * c1f2 * col_m2, 0, NULL, NULL, NULL);
  m2i = clEnqueueMapBuffer(queue, kernelm2i, CL_TRUE, CL_MAP_WRITE|CL_MAP_READ, 0, sizeof(cl_float) * c1f2 * col_m2, 0, NULL, NULL, NULL);
  rer = clEnqueueMapBuffer(queue, kernelrer, CL_TRUE, CL_MAP_WRITE|CL_MAP_READ, 0, sizeof(cl_float) * fil_m1 * col_m2, 0, NULL, NULL, NULL);
  rei = clEnqueueMapBuffer(queue, kernelrei, CL_TRUE, CL_MAP_WRITE|CL_MAP_READ, 0, sizeof(cl_float) * fil_m1 * col_m2, 0, NULL, NULL, NULL);  
	
	status = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&kernelm1r);
	checkError(status, "Failed to set kernel arg 0");
	
	status = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void*)&kernelm1i);
	checkError(status, "Failed to set kernel arg 1");
		
	status = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&kernelm2r);
	checkError(status, "Failed to set kernel arg 2");
	
	status = clSetKernelArg(kernel, 3, sizeof(cl_mem), (void*)&kernelm2i);
	checkError(status, "Failed to set kernel arg 3");
	
	status = clSetKernelArg(kernel, 4, sizeof(cl_mem), (void*)&kernelrer);
	checkError(status, "Failed to set kernel arg 4");
	
	status = clSetKernelArg(kernel, 5, sizeof(cl_mem), (void*)&kernelrei);
	checkError(status, "Failed to set kernel arg 5");
	
	status = clSetKernelArg(kernel, 6, sizeof(cl_mem), (void*)&c1f2);
	checkError(status, "Failed to set kernel arg 6");
	
	status = clSetKernelArg(kernel, 7, sizeof(cl_mem), (void*)&col_m2);
	checkError(status, "Failed to set kernel arg 7");
	
	memcpy(((float*)m1r), ma1r, sizeof(cl_float) * fil_m1 * c1f2);
	memcpy(((float*)m1i), ma1i, sizeof(cl_float) * fil_m1 * c1f2);
	memcpy(((float*)m2r), ma2r, sizeof(cl_float) * c1f2 * col_m2);
	memcpy(((float*)m2i), ma2i, sizeof(cl_float) * c1f2 * col_m2);
  
  // Configure work set over which the kernel will execute
  size_t gSize[2] = {col_m2, fil_m1};
	
  // Launch the kernel
  status = clEnqueueNDRangeKernel(queue, kernel, 2, NULL, gSize, gSize, 0, NULL, NULL);
  checkError(status, "Failed to launch kernel");

  // Wait for command queue to complete pending events
  status = clFinish(queue);
  checkError(status, "Failed to finish");
  
  shmdt(ma1r);
  shmdt(ma1i);
  shmdt(ma2r);
  shmdt(ma2r);

  shmctl(shmid_m1i, IPC_RMID, 0);
  shmctl(shmid_m1r, IPC_RMID, 0);
  shmctl(shmid_m2i, IPC_RMID, 0);
  shmctl(shmid_m2r, IPC_RMID, 0);

  shmid_rer = shmget(SHM_KEY_RER, sizeof(float)*fil_m1*col_m2, 0644|IPC_CREAT);
	shmid_rei = shmget(SHM_KEY_REI, sizeof(float)*fil_m1*col_m2, 0644|IPC_CREAT);

  arer = shmat(shmid_rer, NULL, 0);
	arei = shmat(shmid_rei, NULL, 0);

	memcpy(arer, (float*)rer, sizeof(cl_float) * fil_m1 * col_m2);
	memcpy(arei, (float*)rei, sizeof(cl_float) * fil_m1 * col_m2);

	shmdt(arer);
	shmdt(arei);
	
	cleanup();
  return 0;

}

void cleanup() {

  if(kernelm1r) {
    clEnqueueUnmapMemObject(queue, kernelm1r, m1r, 0, NULL, NULL);
    clReleaseMemObject(kernelm1r);
  }
  if(kernelm1i) {
    clEnqueueUnmapMemObject(queue, kernelm1i, m1i, 0, NULL, NULL);
    clReleaseMemObject(kernelm1i);
  }
  if(kernelm2r) {
    clEnqueueUnmapMemObject(queue, kernelm2r, m2r, 0, NULL, NULL);
    clReleaseMemObject(kernelm2r);
  }
    if(kernelm2i) {
    clEnqueueUnmapMemObject(queue, kernelm2i, m2i, 0, NULL, NULL);
    clReleaseMemObject(kernelm2i);
  }
    if(kernelrer) {
    clEnqueueUnmapMemObject(queue, kernelrer, rer, 0, NULL, NULL);
    clReleaseMemObject(kernelrer);
  }
    if(kernelrei) {
    clEnqueueUnmapMemObject(queue, kernelrei, rei, 0, NULL, NULL);
    clReleaseMemObject(kernelrei);
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
