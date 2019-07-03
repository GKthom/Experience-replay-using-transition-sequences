%Experience replay using transition sequences
%Based on paper: https://arxiv.org/abs/1705.10834
%Author: Thommen George Karimpanal
clear all
close all
clc
Qmap={};%visual map of Q function
conv_log=[];
p=parameters();
returnlog={};
parfor kkk=1:p.runs%this many runs
p=parameters();
kkk
avgreturns=[];
%%%%%%%%%%%%%%
Q=zeros(p.a,p.b,p.A);% initialize Q values
t_c=0;% number of successful visits to secondary task goal location
t_v=0;% number of replay updates
targ_pols={};%policies that are successful with respect to the secondary task
targ_pol_ret=[];%returns corresponding to successful policies
virt_pol_log_all={};%virtual policy library
cnt=1;
clog=[];
%%%%%%%%%%%%
for i=1:p.N_iter
    i
    p=parameters();
    if length(targ_pols)>0
        targ_pol_ret=-10000*ones(length(targ_pols),1);% initialize returns corresponding to successful policies to be highly negative
    end
    [Q,t_c,t_v,targ_pols,virt_pol_log,targ_pol_ret]=Q_learn_beh(Q,t_c,t_v,targ_pols,targ_pol_ret,p);%q learning
    virt_pol_log_all{i}=virt_pol_log;%log the virtual policies
    avgreturns(i)=calcret(Q,p,p.target);%evaluate secondary task Q table
end
virt_pol_log_all=virt_pol_log_all(~cellfun('isempty',virt_pol_log_all));
% % % [pol]=gen_opt_pol(p.start,Q,p,p.target);
tvlog(kkk)=t_v
tclog(kkk)=t_c
returnlog{kkk}=avgreturns
beep
end
r=cell2mat(returnlog');
plot(mean(r))
% % Uncomment to get overall results
% avgretlog=zeros(size(avgreturns));
% for i=1:length(returnlog)
%     avgretlog=avgretlog + returnlog{i};
% end
% plot(avgretlog/kkk)% plot returns
% %hallelujah!
load handel
sound(y,Fs)