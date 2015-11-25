function Cont=Contingency(Mem1,Mem2)
  if nargin < 2 || min(size(Mem1)) > 1 || min(size(Mem2)) > 1
     error('Contingency: Requires two vector arguments')
     return
  end

  Cont=zeros(max(Mem1),max(Mem2));

  for i = 1:length(Mem1);
     Cont(Mem1(i),Mem2(i))=Cont(Mem1(i),Mem2(i))+1;
  end
  
  r=max(Mem1);
  c=max(Mem2);
  
  list_t=ismember(1:r,Mem1);
  list_m=ismember(1:c,Mem2);

  Cont=Cont(list_t,list_m);
end