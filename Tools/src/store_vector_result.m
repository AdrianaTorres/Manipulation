%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% store_vector_result.m
%
% Store a vector into yaml file
%
% Anthony Remazeilles & Jawad Masood
% Copyright Tecnalia CTAG 2020
% Beerware license.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function is_ok = store_vector_result(filename, data, labels)

    file_id = fopen(filename, "w");
    fprintf(file_id, "type: 'vector'\n");

    fprintf(file_id, "label: [%s]\n", labels);
    value_str = sprintf("value: [");
    for i = 1:size(data)(2)
        value_str = sprintf("%s%.5f", value_str, data(i));
        if (i!=size(data)(2))
          value_str = sprintf("%s, ", value_str);
        endif
    endfor
    value_str = sprintf("%s]\n", value_str);
    fprintf(file_id, value_str);

    fclose(file_id);
    is_ok = true;
end
