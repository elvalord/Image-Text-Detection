function ncor=updatecor(cor,ncor_count)     %更新角点数组
ncor=zeros(ncor_count,2);         
j=0;
for i=1:size(cor,1)
    if cor(i,1)~=0&&cor(i,2)~=0
        j=j+1;
        ncor(j,1)=cor(i,1);
        ncor(j,2)=cor(i,2);
    end
end 