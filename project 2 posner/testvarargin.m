function [ varargout ] = testvarargin( varargin )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

if nargin > 1 %multiple samples
    
    for i=1:nargout
    varargout{i} = eval(sprintf('true_ans_ind_%d = i^2; ', i));
    end
  

    
    %user_durations = mean_user_durations;
    
else % one sample
    
    true_ans_ind = 1
    user_durations = varargin;
    
end
end



