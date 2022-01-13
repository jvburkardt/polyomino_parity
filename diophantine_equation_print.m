function diophantine_equation_print ( a, b )

%*****************************************************************************80
%
%% diophantine_equation_print() prints a Diophantine equation.
%
%  Discussion:
%
%     A Diophantine equation has the form:
%
%       a1 x1 + a2 x2 + ... + an xn = b
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    11 March 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer a(n): the coefficients of the Diophantine equation.
%
%    integer b: the right hand side of the Diophantine equation.
%
  n = length ( a );

  for i = 1 : n
    if ( i == 1 )
      fprintf ( 1, '    %d*x%d', a(i), i );
    else
      fprintf ( 1, '%+d*x%d', a(i), i );
    end
  end
  fprintf ( 1, ' = %d\n', b );

  return
end

