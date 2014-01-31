#pragma once

#define programCount 32
#define programIndex (threadIdx.x & 31)
#define taskIndex0 (blockIdx.x*4 + (threadIdx.x >> 5))
#define taskCount0 (gridDim.x*4)
#define taskIndex1 (blockIdx.y)
#define taskCount1 (gridDim.y)
#define taskIndex2 (blockIdx.z)
#define taskCount2 (gridDim.z)
#define taskIndex (taskIndex0 + taskCount0*(taskIndex1 + taskCount1*taskIndex2))
#define taskCount (taskCount0*taskCount1*taskCount2)
#define warpIdx (threadIdx.x >> 5)
#define launch(ntx,nty,ntz,func) if (programIndex==0) func<<<dim3(((ntx)+4-1)/4,nty,ntz),128>>>
#define sync cudaDeviceSynchronize()
#define cif if
__device__ __forceinline__ static double __shfl(double x, int lane)
{
  return __hiloint2double(
      __shfl_xor(__double2hiint(x), lane),
      __shfl_xor(__double2loint(x), lane));

}
#define shuffle(x,y) __shfl(x,y)
#define broadcast(x,y) __shfl(x,y)
