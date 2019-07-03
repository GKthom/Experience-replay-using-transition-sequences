% load Qmapall_VTS
% load Qmapall_noVTS
load Qmap_1%with vts
% load Qmap_2%no vts
load Qmap_3%no vts
Q_all=[];
% Q_all=[Qmapall_noVTS Qmapall Qmapall_VTS];
% Q_all=[Qmapall_noVTS Qmapall_VTS];
Q_all=[Qmapall_3 Qmapall];
Qminall=(Q_all-min(min(Q_all)));
Q_all_norm=Qminall/max(max(Qminall));
imshow(imrotate(Q_all_norm,90));