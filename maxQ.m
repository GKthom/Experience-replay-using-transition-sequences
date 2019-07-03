function [Qmax,opt_act]=maxQ(Q,state)
Qmax=max(Q(state(1),state(2),:));
opt_act=argmax(Q(state(1),state(2),:));