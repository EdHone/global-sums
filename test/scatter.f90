program scatter

  use field_mod, only: field_type
  use mpi

  implicit none

  type(field_type) :: global_field, local_field
  integer :: ierr

  call MPI_Init(ierr)

  global_field = field_type(10)
  local_field = global_field%scatter()

  print*, local_field%data
  call MPI_Finalize(ierr)

end program scatter  