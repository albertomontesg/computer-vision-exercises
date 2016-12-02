
fileName = 'video3'
text = ''
data = load('data/params.mat');
params = data.params
params.draw_plots = 1;
params.hist_bin = 16; % default 16
params.alpha = 0;
params.sigma_observe = 0.1; % original 0.1
params.model = 0;
params.num_particles = 300; % original 300
params.sigma_position = 15; % original 15
params.sigma_velocity = 1;
params.initial_velocity = [10 1];

condensationTracker(fileName, params, text);