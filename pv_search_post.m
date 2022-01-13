function pv_search_post ( S1, S2 )

%*****************************************************************************80
%
%% pv_search_post() reports the results of a search for parity violations.
%
%  Discussion:
%
%    Call this function with the results from pv_search().
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    06 June 2020
%
%  Author:
%
%    Marcus Garvie,
%    John Burkardt
%
%  Input:
%
%    integer S1(k1,nf): k1 solutions to the area equation for which
%    a trivial parity violation was found.
%
%    integer S2(k2,nf): k2 solutions to the area equation for which
%    a serious parity violation was found.
%
  [ k1, nf ] = size ( S1 );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  %d trivial parity violations were found:\n', k1 );
  if ( 0 < k1 )
    fprintf ( 1, '\n' );
    for i = 1 : k1
      fprintf ( 1, '  %d: [', i );
      for j = 1 : nf
        fprintf ( 1, ' %d', S1(i,j) );
        if ( j < nf )
          fprintf ( 1, ',' );
        else
          fprintf ( 1, ' ]\n' );
        end
      end
    end
  end

  [ k2, nf ] = size ( S2 );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  %d strong parity violations were found:\n', k2 );
  if ( 0 < k2 )
    fprintf ( 1, '\n' );
    for i = 1 : k2
      fprintf ( 1, '  %d: [', i );
      for j = 1 : nf
        fprintf ( 1, ' %d', S2(i,j) );
        if ( j < nf )
          fprintf ( 1, ',' );
        else
          fprintf ( 1, ' ]\n' );
        end
      end
    end
  end

  return
end

