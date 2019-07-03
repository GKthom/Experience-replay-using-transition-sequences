clear
load J_noVTS_50runs.mat
for i=1:length(returnlog)
    noreplay_res(i)=sum(returnlog{i});
end

load J_vtsnew_ER15k_50runs_v2.mat
for i=1:length(returnlog)
    ERreplay_res(i)=sum(returnlog{i});
end

load J_vtsnew_PER15k_50runs_v2.mat
for i=1:length(returnlog)
    PERreplay_res(i)=sum(returnlog{i});
end

load J_vtsnew_goal_maxTD_50runs.mat
for i=1:length(returnlog)
    VTSreplay_res(i)=sum(returnlog{i});
end

x=VTSreplay_res';
y=noreplay_res';

[h,p,ci,stats] = ttest2(x,y,'tail','right')