function x = diophantine_nd_nonnegative ( a, b )

%*****************************************************************************80
%
%% diophantine_nd_nonnegative() finds nonnegative diophantine solutions.
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
%     We are seeking all nonnegative integer solutions x.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    03 June 2020
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

%
%  Treat A as a column vector.
%
  a = a(:);
%
%  Initialize.
%
  n = length ( a );
  x = [];
  j = 0;
  r = b;
  y = zeros ( n, 1 );
%
%  Construct a vector Y that is a possible solution.
%
  while ( true )

    r = b;
    for i = 1 : j
      r = r - a(i) * y(i);
    end
%
%  We have a partial vector Y.  Get next component.
%
    if ( j < n )
      j = j + 1;
      y(j) = floor ( r / a(j) );
%
%  We have a full vector Y.
%
    else
%
%  Is it a solution?
%
      if ( r == 0 )
        x = [ x; y' ];
      end
%
%  Find last nonzero Y entry, decrease by 1 and resume search.
%
      while ( 0 < j )

        if ( 0 < y(j) )
          y(j) = y(j) - 1;
          break
        end
        j = j - 1;

      end
%
%  Terminate search.
%
      if ( j == 0 )
        break;
      end

    end

  end
 
  x = sortrows ( x );

  return
end

