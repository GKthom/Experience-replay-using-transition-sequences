% t=linspace(0,1,360);
% sig=sin(2*pi*t);
% err=randn(1,360);
% l=1:10:360; %Indices in interval
% err_sam=err(l);
% sig_sam=sig(l);
% %Plot the Error in the Signal
% errorbar(l,sig_sam,err_sam);

l=1:1000; %Indices in interval
load returns_puddle_world
load('var_b_J_vtsnew_PER15k.mat')
load('var_b_J_vtsnew_goal_maxTD.mat')
load('var_b_J_vtsnew_ER15k.mat')
load('var_b_J_noVTS.mat')

var_b_J_vtsnew_PER15k=sqrt(var_b_J_vtsnew_PER15k);
var_b_J_vtsnew_goal_max=sqrt(var_b_J_vtsnew_goal_maxTD);
var_b_J_vtsnew_ER15k=sqrt(var_b_J_vtsnew_ER15k);
var_b_J_noVTS=sqrt(var_b_J_noVTS);
hold on
retsamp=returns_VTS(l);
varsamp=var_b_J_vtsnew_goal_max(l);
varsamp=NaN*ones(1000,1);
varsamp(1:200:1000)=var_b_J_vtsnew_goal_max(1:200:1000);
vts=errorbar(l,retsamp,varsamp);
set(vts,'color','r','LineWidth',2);
v=varsamp;

retsamp=returns_ER(l);
varsamp=var_b_J_vtsnew_ER15k(l);
varsamp=NaN*ones(1000,1);
varsamp(1:200:1000)=var_b_J_vtsnew_ER15k(1:200:1000);
er=errorbar(l,retsamp,varsamp);
set(er,'color','b','LineWidth',2);
v=varsamp+v;

retsamp=returns_PER(l);
varsamp=var_b_J_vtsnew_PER15k(l);
varsamp=NaN*ones(1000,1);
varsamp(1:200:1000)=var_b_J_vtsnew_PER15k(1:200:1000);
per=errorbar(l,retsamp,varsamp,'k');
set(per,'color',[0.2 0.6 0.2],'LineWidth',2);
v=varsamp+v;

retsamp=returns_noreplay(l);
varsamp=var_b_J_noVTS(l);
varsamp=NaN*ones(1000,1);
varsamp(1:200:1000)=returns_noreplay(1:200:1000);
noreplay=errorbar(l,retsamp,varsamp,'g');
set(noreplay,'LineWidth',2,'Color',[0.6 0.2 0.7]);
v=varsamp+v;

%%%%%%%%Labels%%%%%%%%%
set(gca, ...
    'Box'         , 'on'     , ...
    'TickDir'     , 'in'     , ...
    'TickLength'  , [.015 .015] , ...
        'XMinorTick'  , 'off'      , ...
    'YMinorTick'  , 'off'      , ...
    'YGrid'       , 'off'      , ...
    'XGrid'       , 'off'       , ...
    'XColor'      , [.2 .2 .2], ...
    'YColor'      , [.2 .2 .2], ...
    'XTick'       ,[0:200:1000], ...
    'YTick'       ,[-1000:1000:5000],...
     'FontSize'    , 16, ... 
     'FontName', 'Times', ...
    'LineWidth'   , 1.         );

xlabel('Number of episodes','FontSize',20,'Interpreter','latex')
ylabel('Average return','FontSize',20,'Interpreter','latex')

%%%%%%%%Legend%%%%%%%%%
h_legend=legend('Experience replay: transition sequences',...
    'Experience replay: uniform random sampling',...
    'Prioritized experience replay (proportional)',...
    '$Q$-learning without experience replay');
legend boxoff
set(h_legend,'FontSize',16,'Interpreter','latex','Location','SouthEast');
%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%Textbox%%%%%%%%
dim = [.15 .6 .3 .3];
%str = '\rho=0.0065';
tt=text(50,2600,'$\rho=0.0065$','Interpreter','latex','FontSize',22);
%annotation('textbox',dim,'String',str,'FitBoxToText','on','LineStyle','none','FontWeight','bold','FontSize',14,'FontName','Arial','Interpreter','latex');
%%%%%%%%%%%%%%%%%%%%%%
v=v/4;
mean(v)
