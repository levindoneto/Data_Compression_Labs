
% process outputs of run_length_encoder
rl_row_len;
rl_row_run;
rl_row_valid;
rl_row_end;
% find the last row end position.
no_outputs = size(rl_row_end.Data,1);
last_pos = no_outputs;
for i = no_outputs:-1:1
    if rl_row_valid.Data(last_pos)== 1 && rl_row_end.Data(last_pos-1) == 0
        break;
    else
        last_pos = last_pos -1;
    end
end
mask = rl_row_valid.Data ==1;
mask(last_pos + 1:end) = 0;

rl_row_len_a = rl_row_len.Data(mask);
rl_row_run_a = rl_row_run.Data(mask);
rl_row_end_a = rl_row_end.Data(mask);
rl_row_len_white = rl_row_len_a(rl_row_run_a == 0);
rl_row_len_black = rl_row_len_a(rl_row_run_a == 1);

%compute make/terminal code histogram of white;
term_code_white = mod(rl_row_len_white,64);
make_code_white = floor(rl_row_len_white/64);
subplot(2,2,1); histogram(make_code_white,[0:31]); title('White - m');
subplot(2,2,2); histogram(term_code_white,[0:63]); title('White - t');
term_code_black = mod(rl_row_len_black,64);
make_code_black = floor(rl_row_len_black/64);
subplot(2,2,3); histogram(make_code_black,[0:31]); title('Black - m');
subplot(2,2,4); histogram(term_code_black,[0:63]); title('Black - t');

% process outputs of huffman encoding.
code_make_len;
code_make_val;
code_terminal_val;
code_terminal_len;
code_eor;
code_valid;
% find the last row end position.
no_outputs_code = size(code_eor.Data,1);
last_pos_code = no_outputs_code;
for i = no_outputs_code:-1:1
    if code_valid.Data(last_pos_code)== 1 && code_eor.Data(last_pos_code-1) == 0
        break;
    elseif code_valid.Data(last_pos_code-1)== 0 && code_eor.Data(last_pos_code) == 1
        break;
    else
        last_pos_code = last_pos_code -1;
    end
end
mask_code = code_valid.Data ==1;
mask_code(last_pos_code + 1:end) = 0;

code_make_len_d = code_make_len.Data(mask_code);
code_make_val_d = code_make_val.Data(mask_code);

code_terminal_val_d = code_terminal_val.Data(mask_code);
code_terminal_len_d = code_terminal_len.Data(mask_code);

code_eor_d = code_eor.Data(mask_code);

no_rows = sum(code_eor_d(:));
code_make_terminal_length = sum(code_make_len_d(:)) + sum(code_terminal_len_d(:));


code_length =  code_make_terminal_length + no_rows * 12;

original_length = nx*ny;

compress_ratio = original_length /code_length

text = sprintf('compress ratio %f',compress_ratio);
figure; imshow(ibw); title(text);

