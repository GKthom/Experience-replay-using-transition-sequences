function [max_arg]=argmax(vector)
%Find max argument of a vector
max_arg=find(vector==max(vector));
if length(max_arg)>1
    max_arg=max_arg(randi(length(max_arg)));
end