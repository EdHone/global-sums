!!
module sum_kernel_mod

  use field_mod, only: field_type

  implicit none

contains

  subroutine sum_kernel(data, sum)

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

  end subroutine sum_kernel

end module sum_kernel_mod