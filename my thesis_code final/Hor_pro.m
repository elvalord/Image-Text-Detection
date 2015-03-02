function [lincnt,lintop,linbot] = Hor_pro(Image, bottom, top, left, right)
hei=bottom-top+1;
hp_cnt = zeros(hei,1);
q = 0;  
for i = top:bottom
    q = q + 1;
    for j = left:right                    %每一列
        if Image(i,j) == 1;               %白点
            hp_cnt(q) = hp_cnt(q) + 1;    %直方图统计加1
        end
    end
end
hp_cnt(1)=0;
hp_cnt(q)=0;

thred = 0.8*mean(hp_cnt);
for i = 1:q
    if hp_cnt(i) <= thred                %点数太少的删除
       hp_cnt(i) = 0;
    end
end

k = 0; 
m = 0;
left_temp = zeros(1, 20);
right_temp = zeros(1, 20);
for i = 1:(q-1)                         %统计边界点(投影为0)
    if (hp_cnt(i) == 0)&&(hp_cnt(i+1) ~= 0)
       k = k + 1;
       left_temp(k) = i;
    end
    if (hp_cnt(i) ~= 0)&&(hp_cnt(i+1) == 0)
       m = m + 1;
       right_temp(m) = i+1;
    end
end
%qq=1:q;
%figure(6),
%plot(qq,hp_cnt,'r');
%hold on
%plot(qq,(4/5)*mean(hp_cnt),'b');

thred1 = floor(0.05*q);
%if m == k
    for j = 1:k                         %投影太窄的删除
        if right_temp(j) - left_temp(j) < thred1  
           left_temp(j) = 0;
           right_temp(j) = 0;
        end
    end
%end

lintop=zeros(k,1);
linbot=zeros(k,1);
n = 0;
L = 0;
for j = 1:k                             %得到各行上下边界坐标
    if left_temp(j) ~= 0
        n = n + 1;
        lintop(n) = left_temp(j) + top;
    end
    if right_temp(j) ~= 0
        L = L + 1;
        linbot(L) = right_temp(j) + top; 
    end
end   

lincnt = L;
end




