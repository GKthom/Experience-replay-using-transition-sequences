function test_pol(pol,p)
figure
for i=1:p.a
    for j=1:p.b
        if p.world(i,j)>0
            h0=scatter(i,j,'k','filled');
            hold on
        end
    end
end

h1=scatter(p.target(1),p.target(2),500,'r','filled');
h2=scatter(p.target2(1),p.target2(2),500,'b','filled');

state=pol(1,1:3);
spol=size(pol);
for i=1:spol(1)
    
    state=pol(i,1:3);
    ha=scatter(state(1),state(2),200,[0.1 0.6 0.1],'filled');
    hold on
    pause(0.01)
end