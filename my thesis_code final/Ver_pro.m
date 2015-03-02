function [vlincnt,linlef,linrig] = Ver_pro(Image,lncnt,lntop,lnbot,left,right)
wid=right-left+1;
vp_cnt = zeros(lncnt,wid);
 
for i=1:lncnt   
    if lntop(i)~=0&&lnbot(i)~=0
        q = 0;
        for m = left:right
            q = q + 1;
            for n =lntop(i):lnbot(i)                     %每一列
                if Image(n,m) == 1;                     %白点
                    vp_cnt(i,q) = vp_cnt(i,q) + 1;    %直方图统计加1
                end
            end
        end
    end
end

thred=zeros(1,lncnt);                               %边缘太少的删除
for i=1:lncnt
    if lntop(i)~=0&&lnbot(i)~=0
    thred(i) = 0.5*mean(vp_cnt(i,:));
    vp_cnt(i,1)=0;
    vp_cnt(i,q)=0;
        for j = 1:q
            if vp_cnt(i,j) < thred(i)                
               vp_cnt(i,j) = 0;
            end
        end
    end
end

k=zeros(1,lncnt);
m=zeros(1,lncnt);
left_temp = zeros(lncnt, 80);
right_temp = zeros(lncnt, 80);
for g=1:lncnt
    if lntop(g)~=0&&lnbot(g)~=0
        for i = 1:(q-1)                                     %统计边界点(投影为0)
            if (vp_cnt(g,i) == 0)&&(vp_cnt(g,i+1) ~= 0)
               k(g) = k(g) + 1;
               left_temp(g,k(g)) = i;
            end
            if (vp_cnt(g,i) ~= 0)&&(vp_cnt(g,i+1) == 0)
               m(g)= m(g) + 1;
               right_temp(g,m(g)) = i+1;
            end
        end
    end
end

thred1 = floor(0.015*wid);
for i=1:lncnt
    if lntop(i)~=0&&lnbot(i)~=0
        for j = 1:k(i)                                      %投影太窄的删除
            if right_temp(i,j) - left_temp(i,j) <= thred1  
               left_temp(i,j) = 0;
               right_temp(i,j) = 0;
            end
        end
    end
end

linlef=zeros(1,lncnt);
linrig=zeros(1,lncnt);
nu=0;
for i=1:lncnt
    if lntop(i)~=0&&lnbot(i)~=0
        nu=nu+1;
        a=left_temp(i,:);
        linlef(i)=min(a(a>0))+left;
        linrig(i)=max(right_temp(i,:))+left;
    else linlef(i)=0;
        linrig(i)=0;
    end
end   

vlincnt=nu;

%qq=1:q;
%for i=1:lncnt
 %   if lntop(i)~=0&&lnbot(i)~=0
  %      figure(6+i),
   %     plot(qq,vp_cnt(i,:),'r');
    %    hold on
     %   plot(qq,mean(vp_cnt(i,:)),'b');
      %  hold off
    %end
%end

nnii=1;
end


        