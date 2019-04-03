function A=myhilb(n, m)
%MYHILB a demonstrative M-function.
% A=MYHILB(N, M) generates an N by M Hilbert matrix A.
% A=MYHILB(N) generates an N by N square Hilbert matrix.
% MYHILB(N,M) displays ONLY the Hilbert matrix, but do not return any
% matrix back to the calling function.
%
%See also: HILB.

% Designed by Professor Dingyu XUE, Northeastern University, PRC
% 5 April, 1995, Last modified by DYX at 21 March, 2000
if nargout>1, error('Too many output arguments.');
end
if nargin==1, m=n;
elseif nargin==0 | nargin>2
error('Wrong number of iutput arguments.');
end
A1=zeros(n,m);
for i=1: n
for j=1:m
A1(i,j)=1/(i+j-1);
end
end
if nargout==1, A=A1; elseif nargout==0, disp(A1); 
end