function [pol_lib]=filter_pol_lib(pol_lib)
%Filter target policies based on similarity. Go through all the policies, test for
%similarity. Keep only one copy if similar
%Filter targ_pols that are too long? What is too long? 2*act_mem?
pol_lib_temp={};
t_pol={};
sp={};

for i=1:(length(pol_lib)-1)
   t_pol{1}=pol_lib{i};
   t_pol{2}=pol_lib{i+1};
   sp{1}=size(t_pol{1});
   sp{2}=size(t_pol{2});
   short_pol_ind=find(min(sp{1}(1),sp{2}(1))==[sp{1}(1) sp{2}(1)]);
   short_pol_ind=short_pol_ind(1);
   minlength=sp{short_pol_ind}(1);
   if minlength<1000
   poldiff=t_pol{1}(end-minlength+1:end,4)-t_pol{2}(end-minlength+1:end,4);
   if sum(abs(poldiff))<5
       pol_lib_temp{length(pol_lib_temp)+1}=t_pol{short_pol_ind};
   else pol_lib_temp{length(pol_lib_temp)+1}=t_pol{1};
       pol_lib_temp{length(pol_lib_temp)+1}=t_pol{2};       
   end
   end
end
pol_lib=pol_lib_temp;