function f1=Display(f0,top,buttom,left,right,num)
% figure,imshow(I,[]);
% hold on;
% for i=1:num
%   if top(i)~=0
%     plot(left(i),top(i):buttom(i),'r');
%     plot(right(i),top(i):buttom(i),'r');
%     plot(left(i):right(i),top(i),'r');
%     plot(left(i):right(i),buttom(i),'r');
%   end;
% end;
% hold off;
for i=1:num
    if top(i)>4&&left(i)>4
        f0(top(i)-2:buttom(i)+2,left(i)-2:left(i),1)=0;
        f0(top(i)-2:buttom(i)+2,left(i)-2:left(i),2)=0;       
        f0(top(i)-2:buttom(i)+2,left(i)-2:left(i),3)=255;        
        
        f0(top(i)-2:buttom(i)+2,right(i):right(i)+2,1)=0;
        f0(top(i)-2:buttom(i)+2,right(i):right(i)+2,2)=0;
        f0(top(i)-2:buttom(i)+2,right(i):right(i)+2,3)=255;
        
        f0(top(i)-4:top(i)-2,left(i):right(i),1)=0;
        f0(top(i)-4:top(i)-2,left(i):right(i),2)=0;
        f0(top(i)-4:top(i)-2,left(i):right(i),3)=255;
        
        f0(buttom(i)+2:buttom(i)+4,left(i):right(i),1)=0;
        f0(buttom(i)+2:buttom(i)+4,left(i):right(i),2)=0;        
        f0(buttom(i)+2:buttom(i)+4,left(i):right(i),3)=255;

    end;
end;
%figure,imshow(f0,[]);
f1=f0;