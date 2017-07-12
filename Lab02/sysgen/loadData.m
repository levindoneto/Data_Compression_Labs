bwImg = imread('doc1.png');
%bwImg = imread('halftone1.png');
%bw = 1-bwImg(73:122,54:153);
bw = 1-bwImg;
ibw = 1-bw;

fax_in = double(bw);
[ny nx] = size(fax_in);
%sim_time = ny * nx + ny + 10;

[sim_time, sim_rst, sim_valid_i, sim_data_i, sim_row_end_i] = prepareInput(fax_in);
[rom_make_code_values rom_make_code_lens rom_terminal_code_values rom_terminal_code_lens] = loadRomHuffmanTable();