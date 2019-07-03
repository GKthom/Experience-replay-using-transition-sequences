clear all
close all
clc
Qmap={};
conv_log=[];
p=parameters();
returnlog={};
parfor kkk=1:p.runs
    p=parameters();
kkk
avgreturns=[];
ERcntlog=[];
%%%%%%%%%%%%%%
Q=zeros(p.a,p.b,p.A);
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
    [Q,t_c,ER,ERcnt]=Q_learn_PER_beh(Q,t_c,ER,p);
    avgreturns(i)=calcret(Q,p,p.target);
    ERcntlog(i)=ERcnt;
% %     deltaQ=abs(Q2-Q2old);
% %     maxchange(i)=max(max(max(deltaQ)));
%     clog=[clog;evaluateQ(Q2,p)];
%     i=i+1;
end
virt_pol_log_all=virt_pol_log_all(~cellfun('isempty',virt_pol_log_all));
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

% % % avgretlog=zeros(size(avgreturns));
% % % for i=1:length(returnlog)
% % %     avgretlog=avgretlog + returnlog{i};
% % % end
% % % plot(avgretlog/kkk)
save beh_PER_apr2018