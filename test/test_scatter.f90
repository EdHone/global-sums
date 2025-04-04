program test_scatter

  use mpi

  implicit none

  double precision :: global_field(10), local_field(5)
  integer :: ierr, comm_rank, comm_size
  integer(MPI_ADDRESS_KIND), allocatable :: n_send(:), disp(:)

  call MPI_Init(ierr)
  call mpi_comm_rank(mpi_comm_world, comm_rank, ierr)
  call mpi_comm_size(mpi_comm_world, comm_size, ierr)

  allocate(n_send(comm_size))

  call random_init(.true., .true.)
  call random_number(global_field)

  call MPI_Scatterv(global_field, [5], [5], MPI_DOUBLE, local_field, 5, MPI_DOUBLE, 0, mpi_comm_world, ierr)
  print*, comm_rank, local_field

  call MPI_Finalize(ierr)

end program test_scatter  