clear all;
clc

%--------------------------------------%
%----IMPORT RUN DATA FROM .DAT FILE----%
%--------------------------------------%
rawData = importdata('exampleData.dat');
names = rawData.textdata{2};
nchans = size(rawData.data,2);
for n=1:nchans % demultiplex
    [name,names]=strtok(names);
    eval([upper(name) '= rawData.data(:,' num2str(n) ');']);
end


%----------------------------------------%
%----GENERAL DATA VISUALIZATION BEGIN----%
%----------------------------------------%
figure('Name','General data visualization | Slip Anle vs. Lateral Force')
sp_SA_FY=csaps(SA,FY,.1);
hold on
plot(SA, FY, 'color', 'b')
fnplt(sp_SA_FY,'k')
xlabel('Slip Angle')
ylabel('Lateral Force')
line([min(SA) max(SA)],[0 0],'color','k')
line([0 0],[min(FY) max(FY)],'color','k')
legend('Test Data','Fitted Data')


counter = 1:length(SA);
sp_SA = spline(counter,SA);
z=fnzeros(sp_SA);
z=round(z(1,:));

figure('Name','General data visualization | Slip Angle, Lateral Force, Load, Camber & Tire Pressure ')
subplot(5,1,1)
hold on
plot(counter, SA, 'color', 'b')
xlabel('counter')
ylabel('Slip Angle')
line([min(counter) max(counter)],[0 0],'color','k')
line([0 0],[min(SA) max(SA)],'color','k')
for i=2:2:length(z)
    line([z(i) z(i)],[min(SA) max(SA)],'color','r')
end %for i

subplot(5,1,2)
hold on
plot(counter, FY, 'color', 'b')
xlabel('counter')
ylabel('Lateral Force')
line([min(counter) max(counter)],[0 0],'color','k')
line([0 0],[min(FY) max(FY)],'color','k')
for i=2:2:length(z)
    line([z(i) z(i)],[min(FY) max(FY)],'color','r')
end %for i

subplot(5,1,3)
hold on
plot(counter, FZ, 'color', 'b')
xlabel('counter')
ylabel('Load')
line([min(counter) max(counter)],[0 0],'color','k')
line([0 0],[min(FZ) max(FZ)],'color','k')
for i=2:2:length(z)
    line([z(i) z(i)],[min(FZ) max(FZ)],'color','r')
end %for i

subplot(5,1,4)
hold on
plot(counter, IA, 'color', 'b')
xlabel('counter')
ylabel('Camber')
line([min(counter) max(counter)],[0 0],'color','k')
line([0 0],[min(IA) max(IA)],'color','k')
for i=2:2:length(z)
    line([z(i) z(i)],[min(IA) max(IA)],'color','r')
end %for i

subplot(5,1,5)
hold on
plot(counter, P, 'color', 'b')
xlabel('counter')
ylabel('Tire Pressure')
line([min(counter) max(counter)],[0 0],'color','k')
line([0 0],[min(P) max(P)],'color','k')
for i=2:2:length(z)
    line([z(i) z(i)],[min(P) max(P)],'color','r')
end %for i
%----------------------------------------%
%-----GENERAL DATA VISUALIZATION END-----%
%----------------------------------------%

dataMatrix = [ET	V	N	SA	IA	RL	RE	P	FX	FY	FZ	MX	MZ	NFX	NFY	RST	TSTI	TSTC	TSTO	AMBTMP	SR];

%----------------------------------------%
%-----FILTER DATA FOR P=85kPa  BEGIN-----% 
%----------------------------------------%

%----FILTERING ALSO FOR CAMBER 0 BEGIN---%
q=0;
for iP=2:2:10
    saP85ia0=SA(z(iP):z(iP+2));
    fzP85ia0=FZ(z(iP):z(iP+2));
    fyP85ia0=FY(z(iP):z(iP+2));
    mzP85ia0=MZ(z(iP):z(iP+2));
    mxP85ia0=MX(z(iP):z(iP+2));
    rlP85ia0=RL(z(iP):z(iP+2));
    iaP85ia0=IA(z(iP):z(iP+2));
    
    sp_SA_FY=csaps(saP85ia0,fyP85ia0,.1);
    sp_SA_MZ=csaps(saP85ia0,mzP85ia0,.1);
    sp_SA_MX=csaps(saP85ia0,mxP85ia0,.1);
    sp_SA_RL=csaps(saP85ia0,rlP85ia0,.1);

    for sl=floor(min(saP85ia0)):1:ceil(max(saP85ia0))
        q=q+1;
        fmdata(q,1)=sl;
        fmdata(q,2)=round(mean(iaP85ia0));
        fmdata(q,3)=mean(fzP85ia0);
        fmdata(q,4)=fnval(sp_SA_FY,sl);
        fmdata(q,5)=fnval(sp_SA_MZ,sl);
        fmdata(q,6)=fnval(sp_SA_MX,sl);
    end %for s1
end %for iP

fmdata = sortrows(fmdata,[2,1,3]);;

incls = unique(round(fmdata(:,2)))';
nincls = length(incls);
slips = unique(round(fmdata(:,1)))';
nslips = length(slips);

loads = mean(reshape(fmdata(:,3),[],nslips),2)';
nloads = length(loads);

fz0 = reshape(fmdata(:,3),nloads,nslips)';
fy0 = reshape(fmdata(:,4),nloads,nslips)';
mz0 = reshape(fmdata(:,5),nloads,nslips)';
mx0 = reshape(fmdata(:,6),nloads,nslips)';
nfy0 = fy0./fz0; % Normalized FY

LATE_SLIP_VERT = csaps({slips,loads},fy0,.9)
figure('Name','Lateral Force vs. Slip Angle & Vertical Load | Camber 0')
fnplt(LATE_SLIP_VERT)
xlabel('Slip Angle (deg)')
ylabel('Vertical Load (N)')
zlabel('Lateral Force (N)')
view(45,45)
%----FILTERING ALSO FOR CAMBER 0 END-----%

%----FILTERING ALSO FOR CAMBER 2 BEGIN---%
q=0;
for iP=12:2:20
    saP85ia2=SA(z(iP):z(iP+2));
    fzP85ia2=FZ(z(iP):z(iP+2));
    fyP85ia2=FY(z(iP):z(iP+2));
    mzP85ia2=MZ(z(iP):z(iP+2));
    mxP85ia2=MX(z(iP):z(iP+2));
    rlP85ia2=RL(z(iP):z(iP+2));
    iaP85ia2=IA(z(iP):z(iP+2));
    
    sp_SA_FY=csaps(saP85ia2,fyP85ia2,.1);
    sp_SA_MZ=csaps(saP85ia2,mzP85ia2,.1);
    sp_SA_MX=csaps(saP85ia2,mxP85ia2,.1);
    sp_SA_RL=csaps(saP85ia2,rlP85ia2,.1);

    for sl=floor(min(saP85ia2)):1:ceil(max(saP85ia2))
        q=q+1;
        fmdata(q,1)=sl;
        fmdata(q,2)=round(mean(iaP85ia2));
        fmdata(q,3)=mean(fzP85ia2);
        fmdata(q,4)=fnval(sp_SA_FY,sl);
        fmdata(q,5)=fnval(sp_SA_MZ,sl);
        fmdata(q,6)=fnval(sp_SA_MX,sl);
    end %for s1
end %for iP

fmdata = sortrows(fmdata,[2,1,3]);

incls = unique(round(fmdata(:,2)))';
nincls = length(incls);
slips = unique(round(fmdata(:,1)))';
nslips = length(slips);

loads = mean(reshape(fmdata(:,3),[],nslips),2)';
nloads = length(loads);

fz0 = reshape(fmdata(:,3),nloads,nslips)';
fy0 = reshape(fmdata(:,4),nloads,nslips)';
mz0 = reshape(fmdata(:,5),nloads,nslips)';
mx0 = reshape(fmdata(:,6),nloads,nslips)';
nfy0 = fy0./fz0; % Normalized FY

LATE_SLIP_VERT = csaps({slips,loads},fy0,.9)
figure('Name','Lateral Force vs. Slip Angle & Vertical Load | Camber 2')
fnplt(LATE_SLIP_VERT)
xlabel('Slip Angle (deg)')
ylabel('Vertical Load (N)')
zlabel('Lateral Force (N)')
view(45,45)
%----FILTERING ALSO FOR CAMBER 2 END-----%

%----FILTERING ALSO FOR CAMBER 4 BEGIN---%
q=0;
for iP=22:2:30
    saP85ia4=SA(z(iP):z(iP+2));
    fzP85ia4=FZ(z(iP):z(iP+2));
    fyP85ia4=FY(z(iP):z(iP+2));
    mzP85ia4=MZ(z(iP):z(iP+2));
    mxP85ia4=MX(z(iP):z(iP+2));
    rlP85ia4=RL(z(iP):z(iP+2));
    iaP85ia4=IA(z(iP):z(iP+2));
    
    sp_SA_FY=csaps(saP85ia4,fyP85ia4,.1);
    sp_SA_MZ=csaps(saP85ia4,mzP85ia4,.1);
    sp_SA_MX=csaps(saP85ia4,mxP85ia4,.1);
    sp_SA_RL=csaps(saP85ia4,rlP85ia4,.1);

    for sl=floor(min(saP85ia4)):1:ceil(max(saP85ia4))
        q=q+1;
        fmdata(q,1)=sl;
        fmdata(q,2)=round(mean(iaP85ia4));
        fmdata(q,3)=mean(fzP85ia4);
        fmdata(q,4)=fnval(sp_SA_FY,sl);
        fmdata(q,5)=fnval(sp_SA_MZ,sl);
        fmdata(q,6)=fnval(sp_SA_MX,sl);
    end %for s1
end %for iP

fmdata = sortrows(fmdata,[2,1,3]);

incls = unique(round(fmdata(:,2)))';
nincls = length(incls);
slips = unique(round(fmdata(:,1)))';
nslips = length(slips);

loads = mean(reshape(fmdata(:,3),[],nslips),2)';
nloads = length(loads);

fz0 = reshape(fmdata(:,3),nloads,nslips)';
fy0 = reshape(fmdata(:,4),nloads,nslips)';
mz0 = reshape(fmdata(:,5),nloads,nslips)';
mx0 = reshape(fmdata(:,6),nloads,nslips)';
nfy0 = fy0./fz0; % Normalized FY

LATE_SLIP_VERT = csaps({slips,loads},fy0,.9)
figure('Name','Lateral Force vs. Slip Angle & Vertical Load | Camber 4')
fnplt(LATE_SLIP_VERT)
xlabel('Slip Angle (deg)')
ylabel('Vertical Load (N)')
zlabel('Lateral Force (N)')
view(45,45)
%----FILTERING ALSO FOR CAMBER 4 END-----%
%----------------------------------------%
%------FILTER DATA FOR P=85kPa  END------%
%----------------------------------------%


%----------------------------------------%
%-----FILTER DATA FOR P=75kPa  BEGIN-----%
%--FILTERING ALSO FOR CAMBER 0, 2 AND 4--%
%----------------------------------------%
for iP=32:2:62
    
end %for iP
%----------------------------------------%
%------FILTER DATA FOR P=75kPa  END------%
%----------------------------------------%


%----------------------------------------%
%-----FILTER DATA FOR P=95kPa  BEGIN-----%
%--FILTERING ALSO FOR CAMBER 0, 2 AND 4--%
%----------------------------------------%
for iP=64:2:94
    
end %for iP
%----------------------------------------%
%------FILTER DATA FOR P=95kPa  END------%
%----------------------------------------%


