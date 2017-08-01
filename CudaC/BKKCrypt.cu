#include "BKKCrypt.h"
#include <string.h>

#include "device_launch_parameters.h"
#include "cuda_runtime.h"


//Here is the magic, the core of the algorithm
__global__ void BKKCryptKernel(const char *d_in, char *d_out, size_t length)
{
	//every thread process one element, the index of this element:
	size_t index = threadIdx.x + blockIdx.x * blockDim.x;

	if (index < length) {
		d_out[index] = d_in[index];
	}
}


bool BKKCrypt(const char *in, char *out)
{
	char *d_in = NULL;					//pointers to the device memory
	char *d_out = NULL;

	size_t length = strlen(in) + 1;		//size of the input and (hopefully) the output array

	bool returnedValue = true;			

	//allocating device memory
	if (cudaMalloc((void**)&d_in, length) != cudaSuccess) {
		returnedValue = false;
		goto Error;
	}

	if (cudaMalloc((void**)&d_out, length) != cudaSuccess) {
		returnedValue = false;
		goto Error;
	}

	//copy the input array to the device
	if (cudaMemcpy(d_in, in, length, cudaMemcpyHostToDevice) != cudaSuccess) {
		returnedValue = false;
		goto Error;
	}

	//computing the grid and block size.
	//we choose the block size to be equal to the numbers of threads in a warp
	//the grid size is calculated so that we can process every input elements
	cudaDeviceProp device;
	cudaGetDeviceProperties(&device, 0);
	int threadsPerBlock = device.warpSize;
	int blocks = (length + threadsPerBlock - 1) / threadsPerBlock;

	//The magic
	BKKCryptKernel <<<blocks, threadsPerBlock >>> (d_in, d_out, length);

	cudaDeviceSynchronize();
	cudaError_t cudaStatus = cudaGetLastError();
	if (cudaStatus != cudaSuccess) {
		returnedValue = false;
		goto Error;
	}

	//copy the output string to the host
	if (cudaMemcpy(out, d_out, length, cudaMemcpyDeviceToHost) != cudaSuccess) {
		returnedValue = false;
		goto Error;
	}

Error:
	//We have to clean up. Very important!!!
	cudaFree(d_in);
	cudaFree(d_out);
	return returnedValue;
}


