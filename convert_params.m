function [ Q, R ] = convert_params( q, r )
%CONVERT_PARAMS Summary of this function goes here
%   Detailed explanation goes here
R = floor((2*q*r - r*r)/2);
Q = q*q;

end

