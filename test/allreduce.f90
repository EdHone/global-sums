program allreduce

  use field_mod, only: field_type
  use sum_kernel_mod, only: sum_kernel
  use mpi

  implicit none

  type(field_type) :: global_field, local_field
  double precision :: global_sum, local_sum
  integer :: ierr

  call MPI_Init(ierr)

  global_field = field_type(1000000)
  local_field = global_field%scatter()

  call sum_kernel(local_field%data, local_sum)
  call MPI_Allreduce(local_sum, global_sum, 1, MPI_DOUBLE, MPI_SUM, mpi_comm_world, ierr)
  print*, global_sum
  call MPI_Finalize(ierr)
  
end program allreduce  