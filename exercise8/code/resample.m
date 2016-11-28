function [ particles, particles_w ] = resample( particles, particles_w )
%RESAMPLE Resample the particles based on their weights
%   Return these new particles along with their corresponding weights
nParticles = size(particles, 1);
index = floor(random('unif', 0, 1) * nParticles) + 1;
beta = 0;
mw = max(particles_w);
updatedParticles = zeros(nParticles, size(particles, 2));
updatedParticles_w = zeros(nParticles, 1);
for i = 1:nParticles
    beta = beta + random('unif', 0, 1) * 2 * mw;
    while beta > particles_w(index)
        beta = beta - particles_w(index);
        index = mod(index, nParticles) + 1;
    end
    updatedParticles(i,:) = particles(index,:);
    updatedParticles_w(i) = particles_w(index);
end

particles = updatedParticles;
particles_w = updatedParticles_w;
particles_w = particles_w / (sum(particles_w) + eps);
