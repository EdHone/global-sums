program omp

  use sum_kernel_mod, only: sum_kernel_threaded
  use field_mod,      only: field_type
  use mpi

  implicit none
  
  type(field_type), allocatable :: fields(:)
  double precision              :: field_sum
  integer :: n_steps, t, f, ierr

  call MPI_Init(ierr)

  n_steps = 1000
  allocate(fields(1000))
  do f = 1, size(fields)
    fields(f) = field_type(1000)
  end do

  do t= 1, n_steps
    do f = 1, size(fields)
      call sum_kernel_threaded(fields(f)%data, field_sum)
    end do
  end do

  call MPI_Finalize(ierr)

end program omp
