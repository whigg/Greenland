clc,clear;format longload('/home/zez/JI/mat/glacier_opt_third.mat')glacier_new=glacier;fluxgate_angle=load('/home/zez/JI/fluxgate/angle.txt');for g=1:4        mtime=(glacier(g).time1+glacier(g).time2)/2;    x=glacier(g).fluxgate(:,1);    y=glacier(g).fluxgate(:,2);    thick=glacier(g).thick(:,1);    vel=glacier(g).vel;    angle=abs(sind(glacier(g).angle-fluxgate_angle(g)));   % vel=vel.*angle;    [rows,cols]=size(vel);%cols means that the number of velocity image  rows means the number of point we select.     velocity_mid.data=vel(round(rows/2),:);        velocity_mid.date=(glacier(g).time1+glacier(g).time2)/2;    %     %%%filling data%     for k=1:cols                %cols means that the number of velocity image.%         cl=vel(:,k);             %rows means the number of point we select. %         indexss=find(cl<0);%         if(length(indexss)==0)%             continue;%         else%         clf=filldata(cl,indexss);%         vel(:,k)=clf;%         end%     end       for j=1:length(x)-1;        dwidth(j)=sqrt((x(j)-x(j+1))^2+(y(j)-y(j+1))^2);        dvel(j,:)=(vel(j,:)+vel(j+1,:))/2;        dthick(j)=(thick(j)+thick(j+1))/2;    end    discharge(g).data=dwidth.*dthick*dvel*917;    discharge(g).date1=glacier(g).time1;    clear dwidth dthick dvel Colors=[193 187 255 ;255 193 0; 0 255 193; 193 0 255;255 117 255]/255;    [data,index]=sort(velocity_mid.date);    velocity_mid.date(:)=velocity_mid.date(index);    velocity_mid.data(:)=velocity_mid.data(index);        figure    p=plot(velocity_mid.date,velocity_mid.data,'*-')    title(['velocity time series of mid  point' num2str(g)])% figure % for i=1:5% %     p=plot(discharge(g).date3,discharge(g).data/1e12,'*-','color',Colors(i,:));%     ylabel('Gt')%     %     hold on% end% h=legend(p(1:5),{'UI-0','UI-1','UI-2','UI-3','UI-4'});% set(h,'Orientation','horizon');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inteplate the original data                           % %     for l=1:2*length(discharge_temp(g).data)-1%         if (mod(l,2)==0)%             discharge(g).data(l)=(discharge_temp(g).data(l/2)+discharge_temp(g).data(l/2+1))/2;%             discharge(g).date1(l)=discharge_temp(g).date2(l/2);%             discharge(g).date2(l)=discharge_temp(g).date1(l/2+1);%             discharge(g).date3(l)=(discharge_temp(g).date2(l/2)+discharge_temp(g).date1(l/2+1))/2;%         else%             discharge(g).data(l)=discharge_temp(g).data((l+1)/2);%             discharge(g).date1(l)=discharge_temp(g).date1((l+1)/2);%             discharge(g).date2(l)=discharge_temp(g).date2((l+1)/2);%             discharge(g).date3(l)=discharge_temp(g).date3((l+1)/2);%         end%     endfigure     p=plot(discharge(g).date1,discharge(g).data/1e12,'*-');    ylabel('Gt')    title(['ice discharge' num2str(g)])    enddischarge_totle.data=discharge(1).data+discharge(2).data+discharge(3).data+discharge(4).data;discharge_totle.date1=discharge(1).date1;figureplot(discharge_totle.date1,discharge_totle.data/1e12,'*-');ylabel('Gt')title('total mass loss rate')