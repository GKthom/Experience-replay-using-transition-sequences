function  [out] = parameters()

a=30;
b=30;

%%%%Memory parameters%%%%
parameters.runs=30;
parameters.N_targ_pols=50;%n_v
parameters.act_mem=1000;%m_b
parameters.targ_pol_mem=1000;%m_t
%%%%%%%%%%%%%%%%%%%%%%%%%
%Q learning parameters%%
parameters.alpha=0.1;
parameters.gamma=0.9;
parameters.epsilon=0.7;
parameters.highreward=100;
parameters.penalty=-100;
parameters.livingpenalty=-10;%-10;
%%%%%%%%%%%%%%%%%%%%%%%
%Policy library parameters
parameters.delta=1;
%%%%%%%%%%%%%%%%%%%%%%
%World and agent parameters
parameters.a=a;
parameters.b=b;
parameters.N_iter=1000;
parameters.evalsamples=10000;
parameters.target_thresh=1;
parameters.tran_prob=0.8;
parameters.A=9;
parameters.target=[28,2];%[28,2];
parameters.target2=[28,2];%[2,29];%[2,29];
parameters.start=[7,8,0];%[7 8 0];
%%%%%World%%%%%%
world=zeros(a,b);
world(:,1)=1;
world(1,:)=1;
world(:,end)=1;
world(end,:)=1;
% world(1:3,6:8)=1;
world(5:10,10)=1;
world(10,1:10)=1;
world(1:5,26:28)=1;

% % % parameters.target=[28,28];%[28 2]
% % % parameters.target2=[29,2];
% % % parameters.start=[10 10 0];%[7 8 0];
% % % %%%%%World%%%%%%
% % % world=zeros(a,b);
% % % world(:,1)=1;
% % % world(1,:)=1;
% % % world(:,end)=1;
% % % world(end,:)=1;
% % % world(5:13,15)=1;
% % % world(13,1:15)=1;
% % % world(27:30,3:5)=1;
%%%%%%%%%%%%%%
start=[randi(a) randi(b) rand*360];
while world(start(1),start(2))==1||(start(1)==parameters.target(1)&&(start(2)==parameters.target(2)))
    start=[randi(a) randi(b) rand*360];
end
parameters.start=start;%[7,8,0];%[7 8 0];
parameters.world=world;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
out=parameters;