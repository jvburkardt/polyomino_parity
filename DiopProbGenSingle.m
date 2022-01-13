function DiopProbGenSingle ( parities, orders, p, c )

%*****************************************************************************80
%
%% DiopProbGenSingle() is a generic solver for specific diophantine problems.
%
%  Modified:
%
%    May 25, 2020
%
%  Author:
%
%    Marcus Garvie
%
%  Input:
%
%    integer PARITIES(R+F): zero parities followed by nonzero parities.
%
%    integer ORDERS(F): areas of tiles with nonzero parity.
%
%    integer P: parity of the target region.
%
%    integer C: area of the target region.
%

fprintf('\n')
% For a given set of polyominoes and our choice of polyomino 'family' (indexed by n) we 
% search for parity violations. 
    N = c;
    % For each n we solve the area equation for solutions { (n1, n2, ..., nF) }
    % We then need to check whether each one leads to a parity violation
    S = diophantine_nd_positive( orders, N ); 
    S = sortrows(S);  % small transformation so output compatible here 
    if isempty(S)
        error('No solutions to area equation for n = %d\n',n)
    end
    
    [rows,~]  = size(S);
    cnt = 0;
    A = S;
    pos_parities = nonzeros(parities)' ;   % remove the r zero parities from parity vector
    
    % For each solution  (n1, n2, ..., nF) we need to see if the parity
    % equation yields a parity violation. 
    for count = 1:rows
        % Remove any n_i values in the solution vector that correspond to
        % parities p_i = 0, 
        Sp = -nonzeros(-(parities>0).*S(count,:))';  % i.e.,  [n_{r+1}, n_{r+2}, ..., n_F]
        k = ( p +pos_parities*Sp' )/2;  % pos_parities*Sp' = p_{r+1}*n_{r+1} + ... + p_F*n_F
        % solve for solutions { (a_{r+1}, a_{r+2}, ..., a_F) }
        SS0 = diophantine_nd_nonnegative( pos_parities, k );  % solve for solutions (a_{r+1}, a_{r+2}, ..., a_F)
        SS = sortrows(SS0);  % small transformation so output compatible here
        [r,~] = size(SS);
        if  isempty(SS)   % no solution to the diophantine equation
            % We wish to keep the [n1 n2 ... nF] row as this corresponds to
            % a parity violation. Might be due to the GCD condition
            % failing, but we don't check.
            cnt = cnt + 1;
            if cnt == rows
                fprintf('We have parity violations for all n = %d !! \n',n)
                fprintf('\n')
                disp('Press any key to continue')
                fprintf('\n')
                pause
            end
        else     %  SS NOT empty
            for i = 1:r
                if all( SS(i,:) <= Sp ) % all a_k <= n_k, so no parity violation
                    B = S(count,:);  % i.e. [n1 n2 ... nF]  
                    A = setdiff(A, B,'rows');   % remove row  [n1 n2 ... nF] from A
                    break   % don't need to check the other (a_{r+1}, a_{r+2}, ..., a_F) solutions
                end
            end
        end
    end
    if isempty(A)
        fprintf('\n')
        fprintf('No parity violations\n')
        fprintf('\n')
    else
        A = sortrows(A);
        [nrows,ncols] = size(A);
        if pos_parities*Sp' < p   % i.e., max possible sum of parities  < parity of target region
            disp('Each row [n1 n2 ... nF] in the array below yields a TRIVIAL parity violation: ')
            disp('Press any key to continue')
            fprintf('\n')
            pause
            fprintf('\n')
            disp(A)
            fprintf('\n')
        else
            fprintf('\n')
            disp('Each row [n1 n2 ... nF] in the array below yields a parity violation: ')
            disp('Press any key to continue')
            fprintf('\n')
            pause
            fprintf('\n')
            disp(A)
            fprintf('\n')
        end
    end

