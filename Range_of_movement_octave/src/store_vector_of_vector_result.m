function is_ok = store_vector_of_vector_result(filename, data1, data2, data3, data4, data5, data6, labels1, labels2, labels3, labels4, labels5, labels6)
  
    function store_one_vector(data, labels, file_id)
        fprintf(file_id, " - label: [%s]\n", labels);
        value_str = sprintf("   value: [");
        for i = 1:size(data)(2)
          value_str = sprintf("%s%.5f", value_str, data(i));
          if (i!=size(data)(2))
            value_str = sprintf("%s, ", value_str);
          endif
        endfor
        value_str = sprintf("%s]\n", value_str);
        fprintf(file_id, value_str);
    endfunction

    file_id = fopen(filename, "w");
    fprintf(file_id, "type: 'vector_of_vector'\n");
    fprintf(file_id, "values:\n");
    
    store_one_vector(data1, labels1, file_id)
    store_one_vector(data2, labels2, file_id)
    store_one_vector(data3, labels3, file_id)
    store_one_vector(data4, labels4, file_id)
    store_one_vector(data5, labels5, file_id)
    store_one_vector(data6, labels6, file_id)
    

    fclose(file_id);
    is_ok = true;
end