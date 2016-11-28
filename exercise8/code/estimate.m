function [ meanState ] = estimate( particles, particles_w )
%ESTIMATE Estimate the mean state of the given particles and their weights.
%   Detailed explanation goes here
meanState = sum(particles .* repmat(particles_w, 1, size(particles, 2)), 1);


