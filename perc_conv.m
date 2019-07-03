function [perc,pp]=perc_conv(Q,goal,p)
for i=1:p.a
for j=1:p.b
[pol]=gen_opt_pol([i j 0],Q,p,goal);
pp(i,j)=length(pol);
end
end
perc=(length(find(pp<101)))/(p.a*p.b);