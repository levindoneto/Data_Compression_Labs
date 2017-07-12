function dec= huffman2dec( binarray)
str = num2str(binarray);
str(isspace(str)) = '';
dec = bin2dec(str);
end