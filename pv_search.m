function [ S1, S2 ] = pv_search ( parities, orders, p, c )

%*****************************************************************************80
%
%% pv_search() searches for parity violations.
%
%  Discussion:
%
%    This function considers possible tilings of a region by polyominoes.
%
%    It first determines all combinations of the polyominoes which 
%    have the same total area as the region.
%
%    Then it uses parity arguments to reject certain solutions.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    17 June 2020
%
%  Author:
%
%    Marcus Garvie,
%    John Burkardt
%
%  Input:
%
%    integer parities(nf): the parity of each polyomino.
%
%    integer orders(nf): the area each polyomino.
%
%    integer p: the parity of the region to be tiled.
%
%    integer c: the area of the region to be tiled.
%
%  Output:
%
%    integer S1(k1,nf): k1 solutions to the area equation for which
%    a trivial parity violation was found.
%
%    integer S2(k2,nf): k2 solutions to the area equation for which
%    a serious parity violation was found.
%
  S1 = [];
  S2 = [];
%
%  Seek solutions of the area equation, { (n1, n2, ..., nF) }
%
  S = diophantine_nd_positive ( orders, c ); 
  ns = size ( S, 1 );

  if ( ns == 0 )
    error ( 'pv_search: There are no solutions to the area equation.' )
    return
  end

  flags = zeros ( ns, 1 );
%
%  Remove the r zero parities.
%
  pos_parities = nonzeros ( parities )' ;   
%
%  Check for parity violations in each area equation solution.
% 
  for i = 1 : ns
%
%  Remove any n_i values corresponding to parities p_i = 0, 
%  i.e.,  [n_{r+1}, n_{r+2}, ..., n_F].
%
    Sp = nonzeros ( ( parities > 0 ) .* S(i,:) )';
%
%  Flag trivial parity violations.
%
    if ( pos_parities * Sp' < p )
      flags(i) = 1;
      continue;
    end
%
%  pos_parities*Sp' = p_{r+1}*n_{r+1} + ... + p_F*n_F
%
    k = ( p + pos_parities * Sp' ) / 2;  
%
%  Solve for solutions { (a_{r+1}, a_{r+2}, ..., a_F) }
%
    T = diophantine_nd_nonnegative ( pos_parities, k );
    nt = size ( T, 1 );
%
%  There is a serious parity violation, unless at least one of the T 
%  solutions satisfies the parity condition.
% 
    flags(i) = 2;
%
%  If, for any T, we have all a_k <= n_k, then S(i) does not violate parity.
%
    for j = 1 : nt

      if ( all ( T(j,:) <= Sp ) )   
        flags(i) = 0;
        break   
      end

    end

  end
%
%  Use the flag array to gather the trivial and serious parity violations.
%
%  S1 = rows of S with iflag = 1 (trivial parity violation).
%  S2 = rows of S with iflag = 2 (serious parity violation).
%
  I1 = find ( flags == 1 );
  S1 = S(I1,:);

  I2 = find ( flags == 2 );
  S2 = S(I2,:);

  return
end

