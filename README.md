# Global sums
A simple demonstration of global sums in Fortran with various levels of optimisation.

The project can be built and run with FPM:

```
export FPM_FC=mpif90 # For MPI builds
fpm build
time fpm run
```

## Plotting results

To visualise the results of running the global sums with different thread counts, run the following commands:
```
fpm install prefix=.
cd plots
python compare_threads.py
```
