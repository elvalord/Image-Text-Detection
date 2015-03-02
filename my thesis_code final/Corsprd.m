function Corsprd(mr,mc)
global table;
global labtab;
global div;
labtab(mr,mc)=1;
%div=10;
up=0;
down=0;
left=0;
right=0;
    if(mr==1)
		left=1;
    end
	if(mc==1)
		up=1;
    end
	if(mc==div)
		down=1;
    end
	if(mr==div)
		right=1;
    end
	if mc~=1
        if(left==0&&table(mr,mc-1)~=0&&labtab(mr,mc-1)~=1)
		Corsprd(mr,mc-1);
        end
    end
	if  mr~=1
        if(up==0&&table(mr-1,mc)~=0&&labtab(mr-1,mc)~=1)
		Corsprd(mr-1,mc);
        end
    end
    if  mr~=div
       if     (right==0&&table(mr+1,mc)~=0&&labtab(mr+1,mc)~=1)
		Corsprd(mr+1,mc);
       end
     end
	if  mc~=div
        if (down==0&&table(mr,mc+1)~=0&&labtab(mr,mc+1)~=1)
		Corsprd(mr,mc+1);	
        end
    end
end

