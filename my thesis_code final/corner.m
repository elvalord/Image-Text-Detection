clc;
clear;
close all;
savepath='F:\project\result\';
Files = dir(strcat('F:\project\textloc\','*.jpg'));
LengthFiles = length(Files);
for ii = 1:LengthFiles;
    I = imread(strcat('F:\project\textloc\',Files(ii).name));
       
Para=[1.5,162,3,0.35,0,1,1];
C=Para(1);
T_angle=Para(2);
sig=Para(3);
H=Para(4);
L=Para(5);
Endpoint=Para(6);
Gap_size=Para(7);

Height=size(I,1);
Width=size(I,2);
if Height>Width&&Height~=640        %图像统一规格
    I=imresize(I,[640 NaN]);
elseif Height<Width&&Width~=640
    I=imresize(I,[NaN 640]);
end;
Height=size(I,1);
Width=size(I,2);

I1=I;                               %I1是RGB图像，I是灰度图
if size(I,3)==3
    I=rgb2gray(I); % Transform RGB image to a Gray one. 
end

tic
BW=EDGE(I,'canny',[L,H]);  % Detect edges
time_for_detecting_edge=toc
%figure(1),imshow(BW);

tic
[curve,curve_start,curve_end,curve_mode,curve_num]=extract_curve(BW,Gap_size);  % Extract curves
time_for_extracting_curve=toc

tic
cout=get_corner(curve,curve_start,curve_end,curve_mode,curve_num,BW,sig,Endpoint,C,T_angle); % Detect corners
time_for_detecting_corner=toc

img=I;
for i=1:size(cout,1)
    img=mark(img,cout(i,1),cout(i,2),5);
end
marked_img=img;
%figure(1),                          %角点检测结果
%imshow(marked_img);
%title('Detected corners')
%imwrite(marked_img,'corner.jpg');

sm=SaliencySR(I);                   %显著性检测结果
%figure(2),imshow(sm);

coutt_count=0;                      %删除显著性差的点
for i=1:size(cout,1)                
    gv=sm(cout(i,1),cout(i,2));
    if gv<0.17
        cout(i,1)=0;
        cout(i,2)=0;
    else coutt_count=coutt_count+1;
    end
end
coutt=updatecor(cout,coutt_count);

couttt_count=0;                     %删除单独孤立和边缘的点
disarry=zeros(coutt_count-1,1);
for m=1:size(coutt,1)
    j=1;
    for n=1:size(coutt,1)
        if m~=n
            dis=sqrt((coutt(m,1)-coutt(n,1)).^2+(coutt(m,2)-coutt(n,2)).^2);
            disarry(j,1)=dis;
            j=j+1;
        end
    end
    if min(disarry(:,1))>50||coutt(m,1)<20||coutt(m,2)<20||coutt(m,1)>(Height-20)||coutt(m,2)>(Width-20)
        coutt(m,1)=0;
        coutt(m,2)=0;
    else couttt_count=couttt_count+1;
    end
end
couttt=updatecor(coutt,couttt_count);
      
%figure(3),                           %画出剩余角点
%plot(couttt(:,2),couttt(:,1),'r+');
%axis([0,480,0,640]);
%set(gca,'ydir','reverse','xaxislocation','top');
global div;
div=10;
[corseg,sdr,sdc]=Location(couttt,Height,Width);%分格统计角点数目以及最密集格子坐标
global table;
table=corseg;
global labtab;
labtab=zeros(div);
Corsprd(sdr,sdc);                              %标记文本区格子
locrow=zeros(10,1);
loccol=zeros(10,1);
[locrow,loccol]=find(labtab==1);
dhgg=floor(Height./div);
dwdd=floor(Width./div);
top=(min(locrow)-1)*dhgg;
if top==0
    top=1;
end
bottom=max(locrow)*dhgg;
left=(min(loccol)-1)*dwdd;
if left==0
    left=1;
end
right=max(loccol)*dwdd;
I22=Display(I1,top,bottom,left,right,1); %计算文本区边际坐标，进行文本粗定位
%figure(4),imshow(I22,[]);
I2=I(top:bottom,left:right);
edim2=EDGE(I2,'canny',[0,0.35]);           % Detect edges
%figure(5),imshow(edim2);

[lncnt,lntop,lnbot] = Hor_pro(BW, bottom, top, left, right); %水平投影得到文本行坐标及行数

lincor=zeros(size(couttt,1),2,lncnt);
lincor_cnt=zeros(1,lncnt);
for j=1:lncnt
    for i=1:size(couttt,1)
        if lntop(j)<=couttt(i,1)&&couttt(i,1)<=lnbot(j)&&left<=couttt(i,2)&&couttt(i,2)<=right
            lincor(i,:,j)=couttt(i,:);
            lincor_cnt(j)=lincor_cnt(j)+1;
        end
    end
end

for j=1:lncnt                               %删除角点个数小于5的文本行
 %   m=0;
  %  for i=1:size(lincor,1)
   %     if lincor(i,1)~=0&&lincor(i,2)~=0
    %        m=m+1;
     %       lincorr(m,1,j)=lincor(i,1);
      %      lincorr(m,2,j)=lincor(i,2);
       % end
  %  end
    if lincor_cnt(j)<5
        lincor(:,:,j)=0;
        lntop(j,1)=0;
        lnbot(j,1)=0;
    end
end

[lncntt,lnlef,lnrig] = Ver_pro(BW,lncnt,lntop,lnbot,left,right)
I33=Display(I1,lntop,lnbot,lnlef,lnrig,lncnt);
%figure(7),imshow(I33);
imwrite(I33,[savepath Files(ii).name],'jpg');
end


    














