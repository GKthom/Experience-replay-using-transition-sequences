function [Q,t_c,ER,ERcnt]=Q_learn_PER_beh(Q,t_c,ER,p)
state=p.start;
targ_found=0;
cnt=1;
ER_mem=2000;
ERcnt=0;
% state=[randi(p.a) randi(p.b) 0];
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
    [Qmax_next,a_next]=maxQ(Q,next_state);
    err=reward+p.gamma*(Qmax_next)-Q(state(1),state(2),a);%Qlearning update
    Q(state(1),state(2),a)=Q(state(1),state(2),a)+p.alpha*(err);
    
    reward2=0;
    s_ER=size(ER);
    if s_ER(1)<=ER_mem
        ER=[ER;state a next_state reward2 reward abs(err)];
    else
        ER(randi(s_ER(1)),:)=[];
        ER=[ER;state a next_state reward2 reward abs(err)];
    end
% % %     ER=sortrows(ER,10);
% % %     ER=flipud(ER);
    probs=ER(:,end)/sum(ER(:,end));
% % %     probs=probs/max(probs);
    %Replay experience
     bb=0;
     mem_ind=randi(length(probs));
     for iii=1:35
if s_ER(1)
        if rand<0.5
% % %         e_r=find(probs>rand);
% % %         mem_ind=e_r(randi(length(e_r)));
        [mem_ind,bb]=selectsample(probs,mem_ind,bb);
        if mem_ind>s_ER(1)
            break
        end
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
    probs=ER(:,end)/sum(ER(:,end));
if ERcnt<30000
    bb=0;
    mem_ind=randi(length(probs));
    for iii=1:(30000-ERcnt)
% % %         mem_ind=randi(s_ER(1));
        [mem_ind,bb]=selectsample(probs,mem_ind,bb);
        [Qmax_next_ER,a_next]=maxQ(Q,[ER(mem_ind,5),ER(mem_ind,6),ER(mem_ind,7)]);
        ER_err=ER(mem_ind,9)+p.gamma*Qmax_next_ER-Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4));
        Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))=Q(ER(mem_ind,1),ER(mem_ind,2),ER(mem_ind,4))+p.alpha*(ER_err);
        ERcnt=ERcnt+1;
    end
end
end