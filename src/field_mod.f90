module field_mod

  use mpi

  implicit none

  private
  public :: field_type

  type, public :: field_type
    double precision, allocatable :: data(:)
  contains
    procedure :: scatter
  end type field_type

  interface field_type
    procedure :: field_type_constructor
  end interface field_type

contains

  function field_type_constructor(size) result(self)

    implicit none

    type(field_type)    :: self
    integer, intent(in) :: size

    allocate(self%data(size))
    call random_init(.true., .true.)
    call random_number(self%data)

  end function field_type_constructor

  function scatter(self) result(local_field)

    implicit none

    class(field_type), intent(inout) :: self

    type(field_type) :: local_field

    integer :: comm_rank, comm_size, ierr
    integer :: snd_n, disp

    call mpi_comm_rank(mpi_comm_world, comm_rank, ierr)
    call mpi_comm_size(mpi_comm_world, comm_size, ierr)
    snd_n = size(self%data) / comm_size
    disp = comm_rank * snd_n

    local_field = field_type(int(snd_n))
    call MPI_Scatterv( self%data, [snd_n], [disp], MPI_DOUBLE, local_field%data, &
                       snd_n, MPI_DOUBLE, 0, mpi_comm_world, ierr )

  end function scatter

end module field_mod
