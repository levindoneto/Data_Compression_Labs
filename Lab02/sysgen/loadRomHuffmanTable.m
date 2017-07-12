function [rom_make_code_values rom_make_code_lens rom_terminal_code_values rom_terminal_code_lens] = loadRomHuffmanTable()

% read and init ROM Huffman Table for make code
rom_make_code_values = zeros(1,64);
rom_make_code_lens = zeros(1,64);
[~,~, tbl_make_code] = xlsread('fax_codes.xlsx',2);
tbl_make_code = tbl_make_code(2:end,:);
[n, ~] = size(tbl_make_code);
for i = 1:32
    idx_white = i;
    idx_black = i +32;
    rom_make_code_values(1,idx_white) = huffman2dec(cell2mat(tbl_make_code(i,3)));
    rom_make_code_values(1,idx_black) = huffman2dec(cell2mat(tbl_make_code(i,4)));
    rom_make_code_lens(1,idx_white) = size(cell2mat(tbl_make_code(i,3)),2);
    rom_make_code_lens(1,idx_black) = size(cell2mat(tbl_make_code(i,4)),2);
end
% there is no make code fro m = 0
rom_make_code_lens(1,1) = 0;
rom_make_code_lens(1,33) = 0;

% read and init ROM Huffman Table for terminal code.
rom_terminal_code_lens = zeros(1,128);
rom_terminal_code_values = zeros(1,128);
[~,~, tbl_term_code] = xlsread('fax_codes.xlsx',1);
tbl_term_code = tbl_term_code(2:end,:);
[n, ~] = size(tbl_term_code);
for i = 1:64
    idx_white = i;
    idx_black = i +64;
    rom_terminal_code_values(1,idx_white) = huffman2dec(cell2mat(tbl_term_code(i,2)));
    rom_terminal_code_values(1,idx_black) = huffman2dec(cell2mat(tbl_term_code(i,3)));
    rom_terminal_code_lens(1,idx_white) = size(cell2mat(tbl_term_code(i,2)),2);
    rom_terminal_code_lens(1,idx_black) = size(cell2mat(tbl_term_code(i,3)),2);
end