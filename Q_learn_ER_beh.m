function [Q,t_c,ER,ERcnt]=Q_learn_ER_beh(Q,t_c,ER,p)
state=p.start;
targ_found=0;
cnt=1;
ER_mem=2000;
% state=[randi(p.a) randi(p.b) 0];
ERcnt=0;
while norm(state(1:2)-p.target)>p.target_thresh&&cnt<2000
    %%%%%%%%%%%%%%%%%%Behaviour policy%%%%%%%%%%%%%%%
    %Select action%
    if rand<p.epsilon
        a=randi(p.A);
    else [Qmax,a]=maxQ(Q,state);
    end
    %%%%%%%%%%%%%%
    next_state=transition(state,a,p);
    if norm(next_state(1:2)-p.target)<=p.target_thresh
        reward=p.highreward;
    elseif p.world(next_state(1),next_state(2))==1
        reward=p.penalty;
    else reward=p.livingpenalty;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        %importance sampling
    allQ=[];
    for is=1:p.A
        allQ(is)=Q(state(1),state(2),is);
    end
    allQ=allQ-min(allQ);
    allQ=allQ/max(allQ);
    targ_prob=allQ(a)/sum(allQ);
%     beh_prob=(p.epsilon/p.A)+((1-p.epsilon)*targ_prob);
    if opt_act==1
        beh_prob=targ_prob;
    else beh_prob=1/p.A;
    end
    if beh_prob>0
        imp_wts=targ_prob/beh_prob;
    else
        imp_wts=0;
    end
%     imp_wts=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [Qmax_next,a_next]=maxQ(Q,next_state);
    err=reward+p.gamma*(Qmax_next)-Q(state(1),state(2),a);%Qlearning update
    Q(state(1),state(2),a)=Q(state(1),state(2),a)+imp_wts*p.alpha*(err);
    %%%%%%%%%%%%%%%%Target policy%%%%%%%%%%%%%%%%%%%%%
    prev_targ_found=targ_found;
%     if norm(next_state(1:2)-p.target2)<=p.target_thresh
%         reward2=p.highreward;
%         %Find successful target policies
%         %if targ_found==0
%             targ_found=1;%set it high only once! 
%         %    t_c=t_c+1;%no. of visits to target
%         %end
%     elseif p.world(next_state(1),next_state(2))==1
%         reward2=p.penalty;
%     else reward2=p.livingpenalty;
%     end
%     [Qmax_next,a_next]=maxQ(Q2,next_state);
%     err=reward2+p.gamma*(Qmax_next)-Q2(state(1),state(2),a);
%     Q2(state(1),state(2),a)=Q2(state(1),state(2),a)+p.alpha*(err);
    %Replay memory
    reward2=0;
    s_ER=size(ER);
    if s_ER(1)<=ER_mem
        ER=[ER;state a next_state reward2 reward];
    else
        ER(randi(s_ER(1)),:)=[];
        ER=[ER;state a next_state reward2 reward];
    end
    
    %Replay experience

        if s_ER(1)>0
            for iii=1:35
            if rand<0.5
        mem_ind=randi(s_ER(1));
        [Qmax_next_ER,a_next]=maxQ(Q,[ER(mem_ind,5),ER(mem_ind,6),ER(mem_ind,7)]);
        ER_err=ER(mem_ind,9)+p.gamma*Qmax_next_ER-Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4));
        Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))=Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))+p.alpha*(ER_err);
        ERcnt=ERcnt+1;
            end
        end
        end
%     end
    
    
    %Replay experience
%     if rand<0.9
%     if s_ER(1)>0
%     for j=1:randi(s_ER(1))
%         mem_ind=randi(s_ER(1));
%         [Qmax_next_ER,a_next]=maxQ(Q,[ER(mem_ind,5),ER(mem_ind,6),ER(mem_ind,7)]);
%         ER_err=ER(mem_ind,8)+p.gamma*Qmax_next_ER-Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4));
%         Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))=Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))+p.alpha*(ER_err);
%     end
%     end
%     end
    
    if p.world(next_state(1),next_state(2))==1
    else
    state=next_state;
    end    
end
s_ER=size(ER);
if s_ER(1)>0
if ERcnt<30000
    for iii=1:(30000-ERcnt)
        mem_ind=randi(s_ER(1));
        [Qmax_next_ER,a_next]=maxQ(Q,[ER(mem_ind,5),ER(mem_ind,6),ER(mem_ind,7)]);
        ER_err=ER(mem_ind,9)+p.gamma*Qmax_next_ER-Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4));
        Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))=Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))+p.alpha*(ER_err);
        ERcnt=ERcnt+1;
    end
end
end