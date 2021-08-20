#Calculation of the Postural Stability for the Lateral Lifting task Without EXO
function Main_PosturalStability_Lateral_Without(file_input, output_folder)
  
[ps_vector_phase1, ps_labels_phase1] = PosturalStabilityLateralWithout_octave(file_input, 1)
close all
[ps_vector_phase2, ps_labels_phase2] = PosturalStabilityLateralWithout_octave(file_input, 2)
close all
[ps_vector_phase3, ps_labels_phase3] = PosturalStabilityLateralWithout_octave(file_input, 3)
close all

filename = strcat(output_folder, "/", "PosturalStability_Lateral_Without", ".yaml");
range_of_movement = store_vector_of_vector_result(filename, ps_vector_phase1, ps_vector_phase2, ps_vector_phase3, [], [], [], ps_labels_phase1, ps_labels_phase2, ps_labels_phase3, [], [], []);
endfunction