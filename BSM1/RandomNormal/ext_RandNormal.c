#include <math.h>
#include <limits.h>
#include <windows.h> 

double ext_RandomNormal(double timein)

{
    unsigned int seed = 0;
    double v1, v2, r;

    timein /= 100;
    seed = (timein - floor(timein)) * UINT_MAX;

    do
    {
        v1 = 2 * ((double) rand()) /((double) 32767) - 1;
        v2 = 2 * ((double) rand()) /((double) 32767) - 1;
        r = v1 * v1 + v2 * v2;
    } while((r >= 1.0) || (r == 0.0));

    return v1 * sqrt( - 2.0 * log(r) / r );
}
