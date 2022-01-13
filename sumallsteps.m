function S = sumallsteps ( A, N, Q )

%*****************************************************************************80
%
%% sumallsteps() finds all sums of A + N signed copies of Q.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    19 June 2020
%
%  Author:
%
%    Marcus Garvie
%    John Burkardt
%
%  Input:
%
%    integer A(na): the vector to be incremented.
%
%    integer N: the number of steps to take.
%
%    integer Q: the magnitude of the steps.
%
%  Output:
%
%    integer S(na*(n+1)): all sums of an entry of A and N signed copies of Q.
%
  na = length ( A );
  nb = N + 1;

  B = ( -N:2:N ) * Q;

  [ X, Y ] = meshgrid ( A, B );
  S = X + Y;
  S = reshape ( S, 1, na*nb );
  S = sort ( S );

  return
end

