function Qmap=gen_Q_map(Q)
Qav=zeros(size(Q(:,:,1)));
s_q=size(Q);
for i =1:s_q(end)
    Qav=Qav+Q(:,:,i);
end
Qmap=Qav;
% for i =1:s_q(1)
%     for j=1:s_q(2)
%         Qm(i,j)=max(Q(i,j,:));
%     end
% end
% % % Qmin=(Qav-min(min(Qav)));
% % % Qmap=Qmin/max(max(Qmin));
% % % imshow(imrotate(Qmap,90))