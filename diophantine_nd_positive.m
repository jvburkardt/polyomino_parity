function x = diophantine_nd_positive ( a, b )

%*****************************************************************************80
%
%% diophantine_nd_positive() finds positive diophantine solutions.
%
%  Discussion:
%
%     We are given a Diophantine equation 
%
%       a1 x1 + a2 x2 + ... + an * xn = b
%
%     for which the coefficients a are positive integers, and
%     the right hand side b is a nonnegative integer.
%
%     We are seeking all strictly positive integer solutions x.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    01 June 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer a(n): the coefficients of the Diophantine equation.
%
%    integer b: the right hand side.
%
%  Output:
%
%    integer x(k,n): k solutions to the equation.
%
  beta = b - sum ( a );

  if ( beta < 0 )
    x = [];
    return
  end

  x = diophantine_nd_nonnegative ( a, beta );
%
%  Increase every solution component by 1.
%
  x = x + 1;

  return
end

