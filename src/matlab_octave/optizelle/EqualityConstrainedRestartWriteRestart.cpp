#include "optizelle.h"

void mexFunction(
    int nOutput,mxArray* pOutput[],
    int nInput,mxArray const * pInput[]
) {
    Optizelle::Matlab::EqualityConstrained::Restart::write_restart(
        nOutput,pOutput,nInput,const_cast <mxArray **> (pInput));
}
