function [retj_im]=ret_image(Q2,p,goal)

retj_im=zeros(p.a,p.b);
wrld=p.world;
for k=1:p.a
for j=1:p.b
 state=[k j 0];
i=1;
ret=0;
for i=1:100
    [Qmax,a]=maxQ(Q2,state);
    state=transition(state,a,p);
    if norm(state(1:2)-goal)<=p.target_thresh
        r=p.highreward;
    elseif wrld(state(1),state(2))==1
        r=p.penalty;
    else r=p.livingpenalty;
    end
    ret=ret+r;
end
retj_im(k,j)=ret;
end
end

