!!
module sum_kernel_mod

  implicit none

  private
  public :: sum_kernel, sum_kernel_threaded

contains

  subroutine sum_kernel(data, sum)

    implicit none

    double precision, allocatable, intent(in)  :: data(:)
    double precision,              intent(out) :: sum
    
    integer :: i

    sum = 0
    do i = 1, size(data)
      sum = sum + data(i)
    end do

  end subroutine sum_kernel

  subroutine sum_kernel_threaded(data, sum)

    implicit none

    double precision, allocatable, intent(in)  :: data(:)
    double precision,              intent(out) :: sum
    
    integer :: i

    sum = 0
    !$omp parallel do reduction(+:sum)
    do i = 1, size(data)
      sum = sum + data(i)
    end do
    !$omp end parallel do

  end subroutine sum_kernel_threaded

end module sum_kernel_mod