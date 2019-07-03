function [retj]=calcret(Q2,p,goal)
% state=p.start;
% i=1;
% ret=0;
% while norm(state(1:2)-goal)>p.target_thresh
%     [Qmax,a]=maxQ(Q2,state);
%     state=transition(state,a,p);
%     if norm(state(1:2)-goal)<=p.target_thresh
%         r=p.highreward;
%     else r=p.livingpenalty;
%     end
%     ret=ret+r;
%     i=i+1;
%     if i>1000
%         ret=ret-1000;
%         break
%     end
% end

% state=p.start;
retj=0;
for j=1:100
state=[round(rand*(p.a)) round(rand*(p.b)) 0];
% state=p.start;
if state(1)<=1
    state(1)=1;
elseif state(1)>=p.a
    state(1)=p.a;
end

if state(2)<=1
    state(2)=1;
elseif state(2)>=p.b
    state(2)=p.b;
end

i=1;
ret=0;
% while norm(state(1)-goal(1))>p.target_thresh
for i=1:100
    [Qmax,a]=maxQ(Q2,state);
    state=transition(state,a,p);
    if norm(state(1:2)-goal)<=p.target_thresh
        r=p.highreward;
    else r=p.livingpenalty;
    end
    ret=ret+r;
%     i=i+1;
%     if i>1000
%         ret=ret-1000;
%         break
%     end
end
retj=retj+ret;
end
retj=retj/j;