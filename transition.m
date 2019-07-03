function [new_state]=transition(state,action,p)

if action==1
    if rand<p.tran_prob
        new_state=[state(1) state(2)+1 90];%up
    else
        new_state=[state(1)+round(2*rand-1) state(2)+1+round(2*rand-1) 90];%up
    end
elseif action==2
    if rand<p.tran_prob
    new_state=[state(1)+1 state(2) 0];%Right
    else new_state=[state(1)+1+round(2*rand-1) state(2)+round(2*rand-1) 0];%Right
    end
elseif action==3
    if rand<p.tran_prob
    new_state=[state(1) state(2)-1 -90];%Down
    else new_state=[state(1)+round(2*rand-1) state(2)-1+round(2*rand-1) -90];%Down
    end
elseif action==4
    if rand<p.tran_prob
    new_state=[state(1)-1 state(2) 180];%left
    else new_state=[state(1)-1+round(2*rand-1) state(2)+round(2*rand-1) 180];%left
    end
elseif action==5
    if rand<p.tran_prob
    new_state=[state(1)+1 state(2)+1 45];%Diagonal up, right
    else new_state=[state(1)+1+round(2*rand-1) state(2)+1+round(2*rand-1) 45];
    end
elseif action==6
    if rand<p.tran_prob
    new_state=[state(1)-1 state(2)+1 135];%Diagonal up, left
    else new_state=[state(1)-1+round(2*rand-1) state(2)+1+round(2*rand-1) 135];%Diagonal up, left
    end
elseif action==7
    if rand<p.tran_prob
    new_state=[state(1)+1 state(2)-1 -45];%Diagonal down, right
    else new_state=[state(1)+1+round(2*rand-1) state(2)-1+round(2*rand-1) -45];%Diagonal down, right 
    end
elseif action==8
    if rand<p.tran_prob
    new_state=[state(1)-1 state(2)-1 -135];%Diagonal down, left
    else     new_state=[state(1)-1+round(2*rand-1) state(2)-1+round(2*rand-1) -135];%Diagonal down, left
    end
elseif action==9
    if rand<p.tran_prob
    new_state=[state(1) state(2) state(3)];%Stay put
    else     new_state=[state(1)+round(2*rand-1) state(2)+round(2*rand-1) state(3)];%Stay put
    end
end


if new_state(1)>p.a||new_state(1)<1||new_state(2)>p.b||new_state(2)<1%||p.world(new_state(1),new_state(2))==1
    new_state=state;
end