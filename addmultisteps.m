function [ NUM, NO_SUMS, S ] = addmultisteps ( P, NS, STEPS )

%*****************************************************************************80
%
%% addmultisteps() finds all possible sums from a set.
%
%  Discussion:
%
%    This function calculates all possible sums of N1 elements from the set
%    {+Q1,-Q1}, N2 elements from {+Q2,-Q2}, N3 elements from {+Q3,-Q3}, etc., 
%    and then checks to see how many of these sums equals P
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    22 January 2019
%
%  Author:
%
%    Marcus Garvie
%
%  Input:
%
%    integer P: the target sum.
%
%    integer NS(): a row vector of the number of steps N1, N2, etc we take 
%    with the step-magnitudes in STEPS.
%
%    integer STEPS(): a row vector, corresponding to the step-magnitudes 
%    Q1, Q2, etc. 
%
%  Output:
%
%    integer S(): a row vector of all possible sums of  N1, N2, etc  choices 
%    from the sets {+Q1,-Q1}, {+Q2,-Q2}, etc respectively.
%
%    integer NO_SUMS: the number of sums in S.
%
%    integer NUM: the number of sums in S that equal P.
%

%
%  Check some dimensions.
%
  [ row1, col1 ] = size(NS);
  [ row2, col2 ] = size(STEPS);
  if ( row1 ~= 1 || row2 ~= 1 )
    error ( 'Arrays NS and STEPS must be row vectors.' );
  end
  if ( col1 ~= col2 )
    error ( 'Vectors NS and STEPS must be the same length.' );
  end
  col = col1;
%
%  Recursively call sumallsteps() to calculate all possible sums
%
  SM = [ 0 ];
  for count = 1 : col
    SM = sumallsteps ( SM, NS(count), STEPS(count) );
  end
% 
%  Determine how many sums equal P.
%
  S = sort ( SM );
  NO_SUMS = length ( S );
  NUM = sum ( S == P );

  return
end
