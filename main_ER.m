clear all
close all
clc
Qmap={};
conv_log=[];
p=parameters();
returnlog={};
for kkk=1:p.runs
kkk
%%%%%%%%%%%%%%
Q=zeros(p.a,p.b,p.A);
Q2=zeros(p.a,p.b,p.A);
t_c=0;
t_v=0;
targ_pols={};
targ_pol_ret=[];
virt_pol_log_all={};
cnt=1;
clog=[];
ER=[];
%%%%%%%%%%%%
for i=1:p.N_iter
    i
    p=parameters();
    [Q,Q2,t_c,ER,ERcnt]=Q_learn_ER(Q,Q2,t_c,ER,p);
    avgreturns(i)=calcret(Q2,p,p.target2);
    ERcntlog(i)=ERcnt
% %     deltaQ=abs(Q2-Q2old);
% %     maxchange(i)=max(max(max(deltaQ)));
%     clog=[clog;evaluateQ(Q2,p)];
%     i=i+1;
if mod(i,200)==1
%     Qmap{round(i/200)+1}=gen_Q_map(Q2);
    Qmap{round(i/200)+1}=ret_image(Q2,p,p.target2);
end
end
virt_pol_log_all(~cellfun('isempty',virt_pol_log_all));
%execute policy greedily%

% % % [pol]=gen_opt_pol(p.start,Q,p,p.target);
% % % figure
% % % Qmap=gen_Q_map(Q);
tvlog(kkk)=t_v;
tclog(kkk)=t_c;
ERcntlogmean(kkk)=mean(ERcntlog)
returnlog{kkk}=avgreturns
beep
end

avgretlog=zeros(size(avgreturns));
for i=1:length(returnlog)
    avgretlog=avgretlog + returnlog{i};
end
plot(avgretlog/kkk)
load handel
sound(y,Fs)
Qmapall=[];
for ii=1:length(Qmap)
Qmapall=[Qmapall; Qmap{ii}];
end
% Qminall=(Qmapall-min(min(Qmapall)));
% Qmapall=Qminall/max(max(Qminall));
% imshow(imrotate(Qmapall,90))
% [perc,pp]=perc_conv(Q2,p.target2,p)