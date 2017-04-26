data = [0 1 0 0 1 0 1 0 0 0 1 1 1 1];

% simulation delay
sim_delay = 1;

% reset window size
rst_window_size = 5;

% input size
sim_size = numel(data) + rst_window_size + sim_delay;


index = 0:sim_size-1;

% define input using time series input.
sim_rst = struct;
sim_data_i = struct;

%generate reset signal
sim_rst.time = index;
signal_rst = zeros(sim_size,1);
signal_rst(1:2) = 1; % having two cycle for rst.
sim_rst.signals.values = boolean(signal_rst);

%generate input data
sim_data_i.time = index;
signal_data_i = zeros(sim_size,1);
signal_data_i(rst_window_size+1:end-sim_delay,1) = data(:);
sim_data_i.signals.values = boolean(signal_data_i);

sim_time = sim_size;
