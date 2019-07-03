%prints out the policy, given the start state, Q table and goal location
function [pol]=gen_opt_pol(start,Q,p,goal)
pol=[];
for i=1:p.a
    for j=1:p.b
        if p.world(i,j)>0
            h0=scatter(i,j,'k','filled');
            hold on
        end
    end
end

h1=scatter(p.target(1),p.target(2),500,'r','filled');
h2=scatter(p.target2(1),p.target2(2),500,'b','filled');


axis([0 p.a 0 p.b])
state=start;
ha=scatter(state(1),state(2),[500],[0.1 0.6 0.1]);
count=0;
while norm(state(1:2)-goal)>p.target_thresh
    [Qmax,a]=maxQ(Q,state);
    if count>100
        break
        if rand>(1-p.epsilon)
            a=randi(p.A);
        end
    end
    pol=[pol,a];
    ha=scatter(state(1),state(2),[500/length(pol)],[0.1 0.6 0.1]);
    pause(0.01)
    hold on
    state=transition(state,a,p);
    count=count+1
end