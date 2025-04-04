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

    integer(MPI_ADDRESS_KIND), allocatable :: snd_n(:), disp(:)

  end function scatter

end module field_mod
