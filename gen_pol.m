function [policy,total_return,bumps]=gen_pol(Q,start,world,target,x,y,target_thresh)

state=start;
policy=[];
bumps=0;
total_return=0;
epsilon=0.05;
count=0;

while norm(state(1:2)-target)>target_thresh
    if count>200%start exploring to get out of badly converged state
        break
        if rand>epsilon
            a=randi(A);%explore
        else [Qmax,a]=maxQ(Q,state);
        end
    else
        [Qmax,a]=maxQ(Q,state);
    end
    policy=[policy;a];%record policy
    state=transition(state,a,x,y);%new state
    if world((state(1)),(state(2)))>0
        total_return=total_return-100;
        bumps=bumps+1;
    else total_return=total_return-10;
    end
    count=count+1;
end