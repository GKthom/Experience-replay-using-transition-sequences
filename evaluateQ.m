function [sumerrorsq]=evaluateQ(Q2,p)

load Q2conv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q2samp=[];
Q2convsamp=[];
for i=1:p.evalsamples
    x1=randi(p.a);
    x2=randi(p.b);
    x3=randi(p.A);
    Q2samp(i,:)=Q2(x1,x2,x3);
    Q2convsamp(i,:)=Q2conv(x1,x2,x3);
end

% % % % % Q2min=min(min(min(Q2samp)));
% % % % % Q2convmin=min(min(min(Q2convsamp)));
% % % % % overall_min=min([Q2min Q2convmin]);
% % % % % 
% % % % % 
% % % % % Q2norm=Q2samp-overall_min;
% % % % % Q2max=max(max(max(Q2norm)));
% % % % % Q2convnorm=Q2convsamp-overall_min;
% % % % % Q2convmax=max(max(max(Q2convnorm)));
% % % % % 
% % % % % overall_max=max([Q2max Q2convmax]);
% % % % % 
% % % % % Q2norm=Q2norm/overall_max;
% % % % % Q2convnorm=Q2convnorm/overall_max;
% % % % % 
% % % % % diffQ=Q2convnorm-Q2norm;
% % % % % sumerrorsq=sqrt(sum(sum(sum(diffQ.^2))))/(p.evalsamples);

% % % Q2norm=Q2samp-min(min(min(Q2samp)));
% % % Q2norm=Q2norm/max(max(max(Q2norm)));
% % % Q2convnorm=Q2convsamp-min(min(min(Q2convsamp)));
% % % Q2convnorm=Q2convnorm/max(max(max(Q2convnorm)));
% % % 
% % % diffQ=Q2convnorm-Q2norm;
% % % sumerrorsq=sum(sum(sum(diffQ.^2)))/(p.evalsamples);

diffQ=Q2convsamp-Q2samp;
sumerrorsq=sqrt(sum(diffQ.^2)/(p.evalsamples));

