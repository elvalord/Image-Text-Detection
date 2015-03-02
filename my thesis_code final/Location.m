function [corcnt,mr,mc]=Location(corary,hg,wd) %分块得到角点分布和最密集处
global div;
dhg=ceil(hg./div);
dwd=ceil(wd./div);
corcnt=zeros(div,div);
for i=1:size(corary,1)
    m=ceil(corary(i,1)./dhg);
    n=ceil(corary(i,2)./dwd);
    corcnt(m,n)=corcnt(m,n)+1;
end
maxnum=max(max(corcnt));
[mr,mc]=find(corcnt==maxnum);
if size(mr,1)~=1
    mr=mr(1,1);
    mc=mc(1,1);
end    
end 
        
        
        
        
        