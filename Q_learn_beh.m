function [Q,t_c,t_v,targ_pols,virt_pol_log,targ_pol_ret]=Q_learn_beh(Q,t_c,t_v,targ_pols,targ_pol_ret,p)
state=p.start;
targ_found=0;
traj=[];
pol=[];
TDhist=[];
rew_hist=[];
act_log=[];
state_log=[];
r_tar_log=[];
cnt=1;
counter=0;
virt_pol_log={};
tdav=0;
% state=[randi(p.a) randi(p.b) 0];
while norm(state(1:2)-p.target)>p.target_thresh&&cnt<2000%till goal is reached or max agengt-env interactions are reached
    %%%%%%%%%%%%%%%%%%Primary task%%%%%%%%%%%%%%%
    %Select action%
    if rand<p.epsilon%epsilon greedy exploration
        a=randi(p.A);
    else [Qmax,a]=maxQ(Q,state);
    end
    traj=[traj;state];%save state trajectory
    pol=[pol;a];%state action history
    %%%%%%%%%%%%%%
    next_state=transition(state,a,p);
    %Rewards$
    if norm(next_state(1:2)-p.target)<=p.target_thresh
        reward=p.highreward;
    elseif p.world(next_state(1),next_state(2))==1
        reward=p.penalty;
    else reward=p.livingpenalty;
    end
    [Qmax_next,a_next]=maxQ(Q,next_state);
    err=reward+p.gamma*(Qmax_next)-Q(state(1),state(2),a);%TD error
    Q(state(1),state(2),a)=Q(state(1),state(2),a)+p.alpha*(err);%Qlearning update
    rew_hist=[rew_hist;reward];%save reward history
    TDhist=[TDhist;err];%save history of TD errrors

%     if reward==p.highreward
%         [targ_pols,targ_pol_ret]=pol_sim(targ_pols,[traj pol rew_hist],targ_pol_ret,TDhist,p);%find policies successful wrt to the secondary task
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%Generate virtual target policies%%%%%%%%%%%%%%%
%     if length(act_log)<p.act_mem%remember latest act_mem experiences
%         act_log=[act_log;a];
%         state_log=[state_log;state];
%         r_tar_log=[r_tar_log;reward];
%     else act_log=[act_log(2:end);a];%keep the latest 'act_mem' number of elements in the log variables
%         state_log=[state_log(2:end,:);state];
%         r_tar_log=[r_tar_log(2:end);reward];
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     [virt_targ_pols]=gen_virtual_pols(targ_pols,state);%Check if there is a policy overlap. Return partial target policies
% 
%     %'Simulate' experience by replaying the virtual policy
%       virt_pol_log{cnt}=virt_targ_pols;
%       cnt=cnt+1;
%       svtp=size(virt_targ_pols);
% %%%%%%%%reverse order%%%%%%%%%%%%%%%%%%%%%%      
%       for ii=1:svtp(2)
%           pol_hist=[state_log(1:end-1,:) act_log(1:end-1,:) r_tar_log(1:end-1,:);virt_targ_pols{ii}];%Form virtual trajecotries-concatenate successful trajectories with current trajectory history
%           pol_hist=flipud(pol_hist);%flip the experience order
%           pol_hist=[pol_hist(1,:);pol_hist];
%           s_p_h=size(pol_hist);
%           if length(virt_targ_pols{ii})>0
%               for kk=1:(s_p_h(1)-1)
%                   t_v=t_v+1;%count number of replayed experiences
%                    [Qmax_v,a_next]=maxQ(Q,[pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,3)]);
%                   v_err=pol_hist(kk+1,5)+p.gamma*Qmax_v-Q(pol_hist(kk+1,1),pol_hist(kk+1,2),pol_hist(kk+1,4));%TD error
%                   Q(pol_hist(kk+1,1),pol_hist(kk+1,2),pol_hist(kk+1,4))=Q(pol_hist(kk+1,1),pol_hist(kk+1,2),pol_hist(kk+1,4))+p.alpha*v_err;%Q learning update
%               end             
%           end
%       end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if p.world(next_state(1),next_state(2))==1
    else
    state=next_state;
    end
    cnt=cnt+1;
end
virt_pol_log=virt_pol_log(find(~cellfun(@isempty,virt_pol_log))==1);%get rid of empty policies