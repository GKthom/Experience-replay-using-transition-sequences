clear all
close all
clc
h=zeros(4,1);
h(1)=subplot(1,4,1,'align');
load beh_VTS_may2018_task1_01.mat
r=cell2mat(returnlog');
plot(mean(r),'r','LineWidth',2)
hold on
load beh_ER_may2018_task1_01.mat
r=cell2mat(returnlog');
plot(mean(r),'b','LineWidth',2)
hold on
load beh_PER_may2018_task1_01.mat
r=cell2mat(returnlog');
% plot(mean(r),'k','LineWidth',1)
plot(mean(r),'color',[0.2 0.6 0.2],'LineWidth',2)
hold on
load noreplay_may2018_01.mat
r=cell2mat(returnlog');
% plot(mean(r),'g','LineWidth',1)
plot(mean(r),'Color',[0.6 0.2 0.7],'LineWidth',2)
hold on
axis([0,1000,-1000,3000])
set(gca,'XTick',[0:500:1000],'fontsize',14)
set(gca,'YTick',[-1000:1000:3000],'fontsize',14)
%%%%%%%%Labels%%%%%%%%%
% set(gca,'XTick',[0:500:1000],'fontsize',14)
% set(gca,'YTick',[-1000:1000:2000],'fontsize',14)
ylabel('Average return','FontSize',20)
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% %%%%0.5%%%%%%%%%%%
% h(2)=subplot(1,4,2,'align');
% load beh_VTS_may2018_task1_05.mat
% % axis([0,1000,-1000,2000])
% r=cell2mat(returnlog');
% plot(mean(r),'r','LineWidth',2)
% hold on
% load beh_ER_may2018_task1_05.mat
% r=cell2mat(returnlog');
% plot(mean(r),'b','LineWidth',2)
% hold on
% load beh_PER_may2018_task1_05.mat
% r=cell2mat(returnlog');
% plot(mean(r),'color',[0.2 0.6 0.2],'LineWidth',2)
% hold on
% load noreplay_may2018_05.mat
% r=cell2mat(returnlog');
% plot(mean(r),'Color',[0.6 0.2 0.7],'LineWidth',2)
% hold on
% %%%%%%%%Labels%%%%%%%%%
% axis([0,1000,-1000,3000])
% set(gca,'XTick',[0:500:1000],'fontsize',14)
% set(gca,'YTick',[-1000:1000:3000],'fontsize',14)
% % set(gca,'XTick',[0:500:1000],'fontsize',14)
% % set(gca,'YTick',[-1000:1000:2000],'fontsize',14)
xlabel('Number of episodes','FontSize',20)
% %%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%0.7%%%%%%%%%%
% 
% h(3)=subplot(1,4,3,'align');
% load beh_VTS_may2018_task1_07.mat
% % axis([0,1000,-1000,2000])
% r=cell2mat(returnlog');
% plot(mean(r),'r','LineWidth',2)
% hold on
% load beh_ER_may2018_task1_07.mat
% r=cell2mat(returnlog');
% plot(mean(r),'b','LineWidth',2)
% hold on
% load beh_PER_may2018_task1_07.mat
% r=cell2mat(returnlog');
% % plot(mean(r),'k','LineWidth',1)
% plot(mean(r),'color',[0.2 0.6 0.2],'LineWidth',2)
% hold on
% load noreplay_may2018_07.mat
% r=cell2mat(returnlog');
% % plot(mean(r),'g','LineWidth',1)
% plot(mean(r),'Color',[0.6 0.2 0.7],'LineWidth',2)
% hold on
% %%%%%%%%Labels%%%%%%%%%
% axis([0,1000,-1000,3000])
% set(gca,'XTick',[0:500:1000],'fontsize',14)
% set(gca,'YTick',[-1000:1000:3000],'fontsize',14)
% % set(gca,'XTick',[0:500:1000],'fontsize',14)
% % set(gca,'YTick',[-1000:1000:2000],'fontsize',14)
% %%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%0.9%%%%%%%%
% h(4)=subplot(1,4,4,'align');
% load beh_VTS_may2018_task1.mat
% % axis([0,1000,-1000,2000])
% r=cell2mat(returnlog');
% plot(mean(r),'r','LineWidth',2)
% hold on
% load beh_ER_may2018_task1.mat
% r=cell2mat(returnlog');
% plot(mean(r),'b','LineWidth',2)
% hold on
% load beh_PER_may2018_task1.mat
% r=cell2mat(returnlog');
% % plot(mean(r),'k','LineWidth',1)
% plot(mean(r),'color',[0.2 0.6 0.2],'LineWidth',2)
% hold on
% load noreplay_may2018_09.mat
% r=cell2mat(returnlog');
% % plot(mean(r),'g','LineWidth',1)
% plot(mean(r),'Color',[0.6 0.2 0.7],'LineWidth',2)
% hold on
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%Labels%%%%%%%%%
% set(gca,'XTick',[0:500:1000],'fontsize',14)
% set(gca,'YTick',[-1000:1000:2000],'fontsize',14)
%%%%%%%%%%%%%%%%%%%%%%%
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
    'YTick'       ,[-1000:1000:3000],...
     'FontSize'    , 16, ... 
     'FontName', 'Times', ...
    'LineWidth'   , 1.         );
align_Ylabels(h)


% %%%%%%%%Legend%%%%%%%%%
h_legend=legend('Experience replay with transition sequences','Experience replay with uniform random sampling','Prioritized experience replay (proportional)','Q-learning without experience replay')
legend boxoff
set(h_legend,'FontSize',12);
%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% %%%%%%%%Textbox%%%%%%%%
% dim = [.15 .6 .3 .3];
% str = '\rho=0.0065';
% annotation('textbox',dim,'String',str,'FitBoxToText','on','LineStyle','none','FontWeight','bold','FontSize',14,'FontName','Arial');
%%%%%%%%%%%%%%%%%%%%%%