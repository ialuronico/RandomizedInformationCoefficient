function r = rdc(x,y,k,p)
  % Parameters on Arxiv are different
  % These parameters are from the NIPS paper
  p = size(x,2);
  q = size(y,2);
  if nargin <3
    k = 20;
  end
  sx = 1/6/p;
  sy = 1/6/q;
  if nargin == 4
    sx = sx*p;
    sy = sy*p;
  end
  
  n = size(x,1);
  x = [tiedrank(x)/n ones(n,1)];
  y = [tiedrank(y)/n ones(n,1)];  
  x = sin(sx/size(x,2)*x*randn(size(x,2),k));
  y = sin(sy/size(y,2)*y*randn(size(y,2),k));
  warning('off','stats:canoncorr:NotFullRank')
  [~,~,r] = canoncorr([x ones(n,1)],[y ones(n,1)]);
  r = r(1);
