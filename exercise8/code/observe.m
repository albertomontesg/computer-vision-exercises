function [ particles_w ] = observe( particles, frame, H, W, hist_bin,...
    hist_target, sigma_observe )
%OBSERVE Tihs function make observations
%   Compute for all particles its color histogram describing the bounding
%   box defined by the center of the particle and W and H.

numParticles = size(particles, 1);
particles_w = zeros(numParticles, 1);
for i = 1:numParticles
    xy = particles(i, 1:2);
    xMin = xy(1) - W/2;
    xMax = xy(1) + W/2;
    yMin = xy(2) - H/2;
    yMax = xy(2) + H/2;
    
    max(frame);
    min(frame);
    hist = color_histogram(xMin, yMin, xMax, yMax, frame, hist_bin);
    
    particles_w(i) = 1 / (sqrt(2*pi) * sigma_observe) * ...
        exp( -(chi2_cost(hist, hist_target)) / (2 * sigma_observe^2));
    
end

% Normalize particle weights
particles_w = particles_w / sum(particles_w);

