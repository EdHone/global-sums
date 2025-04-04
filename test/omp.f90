program omp

  use sum_kernel_mod, only: sum_kernel_threaded

  implicit none
  
  double precision, allocatable :: field(:)
  double precision              :: field_sum
  integer :: n_steps, t

  n_steps = 1000
  allocate(field(1000000))
  call random_init(.true., .true.)
  call random_number(field)

  do t= 1, n_steps
    call sum_kernel_threaded(field, field_sum)
  end do

end program omp
