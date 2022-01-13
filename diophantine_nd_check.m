function check = diophantine_nd_check ( a, b )

%*****************************************************************************80
%
%% diophantine_nd_check() checks a proposed Diophantine problem.
%
%  Discussion:
%
%     We are given a Diophantine equation 
%
%       a1 x1 + a2 x2 + ... + an * xn = b
%
%     for which all positive or nonnegative solutions are sought.
%
%     For this problem to be well posed, we require:
%     *) All coefficients A are positive.
%     *) All coefficients A are integers.
%     *) At least one coefficient A must be positive.
%     *) The right hand side B must be nonnegative.
%     *) The right hand side B must be an integer.
%     *) If G is the greatest common divisor of A,
%        then B must be divisible by G.
%
%     If any of these requirements fails, the problem is not suitable for
%     treatment by diophantine_nd_nonnegative() or diophantine_nd_positive().
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    19 May 2020
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
%    logical check: true if this problem is well posed.
%
  check = false;

  if ( any ( a <= 0 ) )
    error ( 'diophantine_nd_check(): a has a nonpositive entry.' )
  end

  if ( ~ i4vec_is_integer ( a ) )
    error ( 'diophantine_nd_check(): some a is not an integer.' );
  end

  if ( sum ( a ) <= 0 )
    error ( 'diophantine_nd_check(): a does not have a positive entry.' );
  end

  if ( b < 0 )
    error ( 'diophantine_nd_check(): b is negative.' );
  end

  if ( ~ i4_is_integer ( b ) )
    error ( 'diophantine_nd_check(): b is not an integer.' );
  end

  d = i4vec_gcd ( a );
  if ( mod ( b, d ) ~= 0 )
    error ( 'diophantine_nd_check(): b is not divisible by gcd ( a ).' );
  end

  check = true;
 
  return
end
function value = i4_is_integer ( a )

%*****************************************************************************80
%
%% i4_is_integer() is TRUE if an I4 has an integer value.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    07 April 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    real A, the value.
%
%  Output:
%
%    logical VALUE, is true if A has an integer value.
%
  value = ( a == round ( a ) );

  return
end
function value = i4vec_gcd ( v )

%*****************************************************************************80
%
%% i4vec_gcd() returns the greatest common divisor of an I4VEC.
%
%  Discussion:
%
%    An I4VEC is a vector of I4's.
%
%    The value GCD returned has the property that it is the greatest integer
%    which evenly divides every entry of V.
%
%    The entries in V may be negative.
%
%    Any zero entries in V are ignored.  If all entries of V are zero,
%    GCD is returned as 1.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    07 April 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer V(:), the vector.
%
%  Output:
%
%    integer VALUE, the greatest common divisor of V.
%
  n = length ( v );

  value = abs ( v(1) );

  for i = 2 : n
    value = gcd ( value, v(i) );
  end

  return
end
function value = i4vec_is_integer ( a )

%*****************************************************************************80
%
%% i4vec_is_integer() is TRUE if all entries of an I4VEC are integer.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    07 April 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    real A(:), the array.
%
%  Output:
%
%    logical VALUE, is true if all entries are integer.
%
  value = all ( a(:) == round ( a(:) ) );

  return
end

