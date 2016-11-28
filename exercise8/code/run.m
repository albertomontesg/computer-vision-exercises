
fileName = 'video2'
text='model'
data = load('data/params.mat');
params = data.params
params.draw_plots = 1;
params.hist_bin = 16;
params.alpha = 0;
params.sigma_observe = 0.1;
params.model = 1;
params.num_particles = 300;
params.sigma_position = 15;
params.sigma_velocity = 1;
params.initial_velocity = [1 10];

condensationTracker(fileName, params, text);