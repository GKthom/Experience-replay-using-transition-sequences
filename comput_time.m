clear
close all
clc

load toclog1010
x(1)=p.act_mem+p.targ_pol_mem;
z(1)=mean(toclog);
err(1)=sqrt(var(toclog));
load toclog100100
x(2)=p.act_mem+p.targ_pol_mem;
z(2)=mean(toclog);
err(2)=sqrt(var(toclog));
load toclog500500
x(3)=p.act_mem+p.targ_pol_mem;
z(3)=mean(toclog);
err(3)=sqrt(var(toclog));
load toclog10001000
x(4)=p.act_mem+p.targ_pol_mem;
z(4)=mean(toclog);
err(4)=sqrt(var(toclog));

load mt_toclog1010
x2(1)=p.act_mem+p.targ_pol_mem;
z2(1)=mean(toclog);
err2(1)=sqrt(var(toclog));
load mt_toclog100100
x2(2)=p.act_mem+p.targ_pol_mem;
z2(2)=mean(toclog);
err2(2)=sqrt(var(toclog));
load mt_toclog500500
x2(3)=p.act_mem+p.targ_pol_mem;
z2(3)=mean(toclog);
err2(3)=sqrt(var(toclog));
load mt_toclog10001000
x2(4)=p.act_mem+p.targ_pol_mem;
z2(4)=mean(toclog);
err2(4)=sqrt(var(toclog));

% scatter(x,z,'Facecolor','r');
% hold on

errorbar(x, z, err,'.b','LineWidth',1);
% scatter(x2,z2,'Facecolor','b');
hold on
errorbar(x2, z2, err2,'.r','LineWidth',1);
%%%%%%%%Labels%%%%%%%%%
set(gca,'XTick',[0:400:2400],'fontsize',14)
set(gca,'YTick',[0:250:1000],'fontsize',14)
xlabel('Transition sequence length','FontSize',14)
ylabel('Computation time per epsiode (s)','FontSize',14)
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%Legend%%%%%%%%%
h_legend=legend('Navigation environment','Mountain-car environment')
legend boxoff
set(h_legend,'FontSize',12);
axis([0 2200 0 750])
%%%%%%%%%%%%%%%%%%%%%%%