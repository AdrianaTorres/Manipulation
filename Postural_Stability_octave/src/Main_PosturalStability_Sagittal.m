#Calculation of the Postural Stability for the Sagittal Lifting task
function Main_PosturalStability_Sagittal(file_input, output_folder)
[ps_vector, ps_labels] = PosturalStabilitySagittal_octave(file_input);
close all

filename = strcat(output_folder, "/", "PosturalStability_SagittalLifting", ".yaml");
store_vector_result(filename, ps_vector, ps_labels);
endfunction