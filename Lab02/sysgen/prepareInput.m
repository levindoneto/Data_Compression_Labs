function [sim_time, sim_rst, sim_valid_i, sim_data_i, sim_row_end_i] = prepareInput(image)
%codegen
[ny nx ] = size(image);

% reset window size
rst_window_size = 5;
% input size
sim_size = ny * nx + ny + rst_window_size;

index = 0:sim_size-1;

% define input using time series input.
sim_rst = struct;
sim_valid_i = struct;
sim_data_i = struct;
sim_row_end_i = struct;

%generate reset signal
sim_rst.time = index;
signal_rst = zeros(sim_size,1);
signal_rst(1:2) = 1; % having two cycle for rst.
sim_rst.signals.values = boolean(signal_rst);

% generate valid signal
sim_valid_i.time = index;
signal_valid_i = ones(sim_size,1);
signal_valid_i(1:rst_window_size) = 0;
sim_valid_i.signals.values = boolean(signal_valid_i);

% generate row  end signal
signal_row_end_i = zeros(sim_size,1);
for j = 1:ny
    cur_index = rst_window_size + j*(nx+1);
    signal_row_end_i(cur_index) = 1;
end
sim_row_end_i = struct;
sim_row_end_i.time = index;
sim_row_end_i.signals.values = boolean(signal_row_end_i);

% generate data signal
signal_data_i = zeros(sim_size,1);
for j = 1:ny
    cur_index_start = rst_window_size + (j-1)*(nx+1)+1;
    signal_data_i(cur_index_start:cur_index_start+nx-1) = image(j,:);
end
sim_data_i = struct;
sim_data_i.time = index;
sim_data_i.signals.values = boolean(signal_data_i);

sim_time = sim_size;
