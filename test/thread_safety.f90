program thread_safety

    use sum_kernel_mod, only: sum_kernel, sum_kernel_threaded
  
    implicit none
    
    double precision, allocatable :: field(:)
    double precision              :: serial_sum, omp_sum
    double precision, parameter   :: tol = 1e-6
  
    allocate(field(1000000))
    call random_init(.true., .true.)
    call random_number(field)
  
    call sum_kernel(field, serial_sum)
    call sum_kernel_threaded(field, omp_sum)

    if (abs(serial_sum - omp_sum) > tol) then
        print*, "OpenMP global sum not thread safe"
        stop 1
    end if
  
end program thread_safety
  