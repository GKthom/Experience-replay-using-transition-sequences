%this function takes historically successful trajectories, and returns
%sections which intersect with the current state. Refer arxiv paper for
%more details.
function [virt_targ_pols]=gen_virtual_pols(targ_pols,state)
virt_targ_pols={};
intersections={};
%Find point of intersection of trajectories
s_t_p=size(targ_pols);
%mark the point of intersection, use the partial policy till this point
%and the partial target policy from there on.
for i=1:s_t_p(end)
    intersections_x=find(state(1)==targ_pols{i}(:,1));% x point of intersection
    intersections_y=find(state(2)==targ_pols{i}(:,2));% y point of intersection
    intersections{i}=max(intersect(intersections_x,intersections_y));%find optimal point of intersection
    if length(intersections{i})>0
        virt_targ_pols{i}=targ_pols{i}(intersections{i}:end,:);
    end    
end
virt_targ_pols=virt_targ_pols(find(~cellfun(@isempty,virt_targ_pols))==1);