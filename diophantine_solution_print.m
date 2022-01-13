function diophantine_solution_print ( a, b, x )

%*****************************************************************************80
%
%% diophantine_solution_print() prints a Diophantine solution.
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
%    integer b: the right hand side of the Diophantine equation.
%
%    integer x(x_num,n): the solutions.
%
  n = length ( a );
  [ x_num, ~ ] = size ( x );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  %d solutions found.\n', x_num );
  if ( 0 < x_num )
    fprintf ( 1, '\n' );
  end

  for i = 1 : x_num
    b2 = sum ( a(1:n) .* x(i,1:n)' );
    if ( b2 ~= b )
      fprintf ( 1, 'BOGUS %d:  ', i );
    else
      fprintf ( 1, '      %d:  ', i );
    end
    for j = 1 : n
      if ( j == 1 )
        fprintf ( 1, '    %d*%d', a(j), x(i,j) );
      else
        fprintf ( 1, '%+d*%d', a(j), x(i,j) );
      end
    end
    fprintf ( 1, ' = %d\n', b2 );
  end

  return
end

