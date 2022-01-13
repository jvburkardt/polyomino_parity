% DiopProbGen.m
%
%  Modified:
%
%    25 May 2020
%
%  Author:
%
%    M. Garvie

% Generic solver for F free polyominoes. 

% clear variables

disp('1: staircase-shapes')
disp('2: pyramid-shapes')
disp('3: jagged-square-shapes')
disp('4: Aztec-Diamond-shapes')
disp('5: 4-notched-square-shapes')
disp('6: 2-notched-square-shapes')
disp('7: 1-notched-square-shapes')
disp('8: Square-shapes')
disp('9: Cross-shapes')
disp('10: parallelogram-shapes')
disp('11: Cross-in-square-shapes')
disp('12: Square-in-square-shapes')
disp('13: Minimal-area-shapes')

fprintf('\n')
family = input('Choose family no. 1 - 13 to search through    ');

fprintf('\n')
parities = input('Enter non-negative parities (assuming r >= 0 zero parities) in form [0 ... 0 p_{r+1} p_{r+2} ... p_F]    ');

fprintf('\n')
orders = input('Enter positive areas of F tiles in form [c1 c2 ... cF]    ');

%
%  The family has been chosen.
%
if family == 1
    
% staircase-shapes 
area = @(n) (n+1)*(n+2)/2;
par = @(n) (n+1+mod(n+1,2))/2;

elseif family == 2

% pyramid-shapes
area = @(n) (n+1)^2;
par = @(n) n+1;

elseif family == 3

% jagged-square-shapes 
area = @(n) 1+2*n+2*n^2;
par = @(n) 2*n + 1;

elseif family == 4

% Aztec-Diamond-shapes 
area = @(n) 2*(n+1)*(n+2);
par =@(n) 0;

elseif family == 5

% 4-notched-square-shapes 
area = @(n)  (n+3)^2-4;
par = @(n) 3*mod(n+1,2);

elseif family == 6

% 2-notched-square-shapes 
area = @(n)  (n+2)^2-2;
par = @(n) 1+mod(n+1,2);

elseif family == 7

% 1-notched-square-shapes 
area = @(n)  n*(n+2);
par = @(n) mod(n,2);

elseif family == 8

% Square-shapes 
area = @(n) n^2;
par = @(n) mod(n,2);

elseif family == 9

% Cross-shapes 
area = @(n) 5*n^2;
par = @(n) 3*mod(n,2);

elseif family == 10

% parallelogram-shapes 
area = @(n) n^2;
par = @(n) n;

elseif family == 11 

% Cross-in-square-shapes (Matlab quickly struggles for large n)
area = @(n) 20*n^2;
par = @(n) 4*mod(n,2);

elseif  choice == 12
 
% Square-inside-square 
area = @(n) 16*n^2;
par =@(n) 0;

else    % choice = 13
 
% Minimal-area-shapes 
area = @(n) 2*n - mod(n,2);
par =@(n) n;

end


fprintf('\n')
mn = 3;  % min to max member of family (indexed by n)
mx = 15;  
% For a given set of polyominoes and our choice of polyomino 'family' (indexed by n) we 
% search for parity violations. 
for n = mn:mx
    N = area(n);
    % For each n we solve the area equation for solutions { (n1, n2, ..., nF) }
    % We then need to check whether each one leads to a parity violation
    S0 = diophantine_nd_positive( orders, N ); 
    S = sortrows(S0');  % small transformation so output compatible here 
    if isempty(S)
        fprintf('No solutions to area equation for n = %d\n',n)
        fprintf('\n')
        disp('Press any key to continue')
        fprintf('\n')
        pause
        continue    % jump to next n value in loop if S empty
    end
    
    [rows,~]  = size(S);
    cnt = 0;
    A = S; % candidates for (n1, n2, ..., nF) solutions that may yield a p.v.
               % solutions thst don't yield a p.v. will be removed
    pos_parities = nonzeros(parities)' ;   % remove the r zero parities from parity vector
    
    % For each solution  (n1, n2, ..., nF) we need to see if the parity
    % equation yields a parity violation. 
    for count = 1:rows
        % Remove any n_i values in the solution vector that correspond to
        % parities p_i = 0, 
        Sp = -nonzeros(-(parities>0).*S(count,:))';  % i.e.,  [n_{r+1}, n_{r+2}, ..., n_F]
        k = ( par(n) +pos_parities*Sp' )/2;  % pos_parities*Sp' = p_{r+1}*n_{r+1} + ... + p_F*n_F
        % solve for solutions { (a_{r+1}, a_{r+2}, ..., a_F) }
        SS0 = diophantine_nd_nonnegative( pos_parities, k );  % solve for solutions (a_{r+1}, a_{r+2}, ..., a_F)
        SS = sortrows(SS0');  % small transformation so output compatible here
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
                    A = setdiff(A, B,'rows');   % remove row  [n1 n2 ... nF] from A as it doesn't yield a p.v.
                    break   % don't need to check the other (a_{r+1}, a_{r+2}, ..., a_F) solutions
                end
            end
        end
    end
    if isempty(A)  % 
        fprintf('\n')
        fprintf('No parity violations for n = %d\n',n)
        fprintf('\n')
    else
        A = sortrows(A);
        [nrows,ncols] = size(A);
        fprintf('When n = %d the number of parity violations is %d\n',n,nrows)
        if pos_parities*Sp' < par(n)   % i.e., max possible sum of parities  < parity of target region
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
end


