function [Q,Q2,t_c,t_v,targ_pols,virt_pol_log,targ_pol_ret]=Q_learn_both(Q,Q2,t_c,t_v,targ_pols,targ_pol_ret,p)
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
while norm(state(1:2)-p.target)>p.target_thresh&&cnt<2000
    %%%%%%%%%%%%%%%%%%Behaviour policy%%%%%%%%%%%%%%%
    %Select action%
    if rand<p.epsilon
        a=randi(p.A);
    else [Qmax,a]=maxQ(Q,state);
    end
    traj=[traj;state];
    pol=[pol;a];
    %%%%%%%%%%%%%%
    next_state=transition(state,a,p);

    if norm(next_state(1:2)-p.target)<=p.target_thresh
        reward=p.highreward;
    elseif p.world(next_state(1),next_state(2))==1
        reward=p.penalty;
    else reward=p.livingpenalty;
    end
    [Qmax_next,a_next]=maxQ(Q,next_state);
    err=reward+p.gamma*(Qmax_next)-Q(state(1),state(2),a);%Qlearning update
    Q(state(1),state(2),a)=Q(state(1),state(2),a)+p.alpha*(err);
    %%%%%%%%%%%%%%%%Target policy%%%%%%%%%%%%%%%%%%%%%
    prev_targ_found=targ_found;
    if norm(next_state(1:2)-p.target2)<=p.target_thresh
        reward2=p.highreward;
        %Find successful target policies
        if targ_found==0
            targ_found=1;%set it high only once! 
            t_c=t_c+1;%no. of visits to target
        end
    elseif p.world(next_state(1),next_state(2))==1
        reward2=p.penalty;
    else reward2=p.livingpenalty;
    end
%     if targ_found~=prev_targ_found
% %         targ_pols{mod(t_c,N_targ_pols)+1}=[traj pol rew_hist;next_state randi(A) -10];
%         [targ_pols,targ_pol_ret]=pol_sim(targ_pols,[traj pol rew_hist;next_state randi(p.A) 100],targ_pol_ret,p);
%     end

    [Qmax_next,a_next]=maxQ(Q2,next_state);
    err=reward2+p.gamma*(Qmax_next)-Q2(state(1),state(2),a);
    Q2(state(1),state(2),a)=Q2(state(1),state(2),a)+p.alpha*(err);

    rew_hist=[rew_hist;reward2];
    TDhist=[TDhist;err];
    
% % %     if length(TDhist)>1
% % %         if (abs(err)-abs(TDhist(length(TDhist)-1)))>0
% % %             [targ_pols,targ_pol_ret]=pol_sim(targ_pols,[traj pol rew_hist],targ_pol_ret,TDhist,p);
% % %         end
% % %     end

% % %     if length(rew_hist)>1
% % % %         if (reward2-rew_hist(length(rew_hist)-1))>0
% % %         if abs(reward2-rew_hist(end-1))>0
% % %             [targ_pols,targ_pol_ret]=pol_sim(targ_pols,[traj pol rew_hist],targ_pol_ret,TDhist,p);
% % %         end
% % %     end
    
% % %     if targ_found~=prev_targ_found
% % %         [targ_pols,targ_pol_ret]=pol_sim(targ_pols,[traj pol rew_hist],targ_pol_ret,TDhist,p);
% % %     end

% % %     if reward2==p.highreward
% % %         [targ_pols,targ_pol_ret]=pol_sim(targ_pols,[traj pol rew_hist],targ_pol_ret,TDhist,p);
% % %     end
    [targ_pols,targ_pol_ret]=pol_sim(targ_pols,[traj pol rew_hist],targ_pol_ret,TDhist,p);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%Generate virtual target policies%%%%%%%%%%%%%%%
 
    %Remember history of the behaviour policy
    if length(act_log)<p.act_mem
        act_log=[act_log;a];
        state_log=[state_log;state];
        r_tar_log=[r_tar_log;reward2];
    else act_log=[act_log(2:end);a];%keep the latest 'act_mem' number of elements in the log variables
        state_log=[state_log(2:end,:);state];
        r_tar_log=[r_tar_log(2:end);reward2];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Check if there is a policy overlap 
    [virt_targ_pols]=gen_virtual_pols(targ_pols,state);%return partial target policies
    %'Simulate' experience by greedily exploiting the virtual policy-memory
    %based method
% % %       virt_pol_log{cnt}=virt_targ_pols;
% % %       cnt=cnt+1;
      svtp=size(virt_targ_pols);
      stp=size(targ_pols);
      if svtp(2)>0
      for ii=1:svtp(2)
          pol_hist=[state_log(1:end-1,:) act_log(1:end-1,:) r_tar_log(1:end-1,:);virt_targ_pols{ii}];        
          %Overlap of behaviour and target trajectories and policies. State log is till (end-1) 
          %to avoid repeat of same state in the traj log
          s_p_h=size(pol_hist);
          if length(virt_targ_pols{ii})>0
              for kk=1:(s_p_h(1)-1)%To (end-1) to avoid the last 'fake' state of the traj pol (because of the kk+1 term below)
                  t_v=t_v+1;
                  Q2oldval=Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4));
                  [Qmax_v,a_next]=maxQ(Q2,[pol_hist(kk+1,1),pol_hist(kk+1,2) 0]);
                  v_err=pol_hist(kk,end)+p.gamma*Qmax_v-Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4));
                  Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4))=Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4))+p.alpha*v_err;
              end
          end
      end
      else 
          for iii=1:stp(2)
          pol_hist=targ_pols{iii};        
          s_p_h=size(pol_hist);
          if length(targ_pols{iii})>0
              for kk=1:(s_p_h(1)-1)%To (end-1) to avoid the last 'fake' state of the traj pol (because of the kk+1 term below)
                  t_v=t_v+1;
                  Q2oldval=Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4));
                  [Qmax_v,a_next]=maxQ(Q2,[pol_hist(kk+1,1),pol_hist(kk+1,2) 0]);
                  v_err=pol_hist(kk,end)+p.gamma*Qmax_v-Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4));
                  Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4))=Q2(pol_hist(kk,1),pol_hist(kk,2),pol_hist(kk,4))+p.alpha*v_err;
              end
          end
          end
      end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %     targ_found=0;
    if p.world(next_state(1),next_state(2))==1
    else
    state=next_state;
    end
    cnt=cnt+1;
end

% virt_pol_log(~cellfun('isempty',virt_pol_log));
virt_pol_log=virt_pol_log(find(~cellfun(@isempty,virt_pol_log))==1);