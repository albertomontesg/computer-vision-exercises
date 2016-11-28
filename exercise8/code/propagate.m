function [ particles ] = propagate( particles, sizeFrame, params )
%PROPAGATE Summary of this function goes here
%   Detailed explanation goes here

nParticles = size(particles, 1);
if params.model == 0
    A = eye(2);
    noise = normrnd(zeros(nParticles, 2), params.sigma_position);
elseif params.model == 1
    A = eye(4);
    A(3) = 1; A(8) = 1;
    noise = [normrnd(zeros(nParticles, 2), params.sigma_position),...
            normrnd(zeros(nParticles, 2), params.sigma_velocity)];
end

particles = particles * A + noise;

% Correct the particles going out of the image frame
particles = max(particles, 0);
particles(:,1) = min(particles(:,1), sizeFrame(2));
particles(:,2) = min(particles(:,2), sizeFrame(1));
