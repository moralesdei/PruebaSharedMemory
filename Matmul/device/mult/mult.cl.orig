	__kernel void Matmul(__global float *m1r,
											 __global float *m1i,
											 __global float *m2r,
											 __global float *m2i,
											 __global float *rer,
											 __global float *rei,
											 const int c1f2,
											 const int col_m2)
  {
    int n;
    int j = get_global_id(0);
    int i = get_global_id(1);
    
    float tmpr = 0.0f;
    float tmpi = 0.0f;   
    
    for(n=0;n<c1f2;n++)
    	{
    		tmpr += (m1r[i*c1f2+n] * m2r[n*col_m2+j]) - (m1i[i*c1f2+n] * m2i[n*col_m2+j]);
    		tmpi += (m1r[i*c1f2+n] * m2i[n*col_m2+j]) + (m1i[i*c1f2+n] * m2r[n*col_m2+j]);
    	}
    	
    rer[i*col_m2+j] = tmpr * (-1);
    rei[i*col_m2+j] = tmpi * (-1);
    
  }
