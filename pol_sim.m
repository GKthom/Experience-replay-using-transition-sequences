%This function maintains the library L or successful trajecotries (refer to paper)
function [traj_pol_lib,targ_pol_ret]=pol_sim(traj_pol_lib,newtrajpol,targ_pol_ret,TDhist,p)

if length(newtrajpol)<p.targ_pol_mem
rtd=(max(abs(TDhist)));%filter the rewards based on max of absolute TD error
%other possible filtering criteria
% % % rtd=max(abs(TDhist));
% % % rtd=td/j;
% % % rtd=r*td/j;
% % % rtd=(abs(TDhist')*newtrajpol(:,5))/length(newtrajpol);
if length(traj_pol_lib)>0
if max(targ_pol_ret)<(p.delta*rtd) 
    traj_pol_lib{length(traj_pol_lib)+1}=newtrajpol;
    targ_pol_ret=[targ_pol_ret;rtd];
end
else traj_pol_lib={newtrajpol};
    targ_pol_ret=rtd;
end
end

if length(traj_pol_lib)>p.N_targ_pols%keep the latest N_targ_pols trajectories
    traj_pol_lib={traj_pol_lib{end-p.N_targ_pols:end}};
    targ_pol_ret=targ_pol_ret(end-p.N_targ_pols:end);
end