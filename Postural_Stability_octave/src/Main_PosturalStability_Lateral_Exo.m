#Calculation of the Postural Stability for the Lateral Lifting task With EXO
function Main_PosturalStability_Lateral_Exo(file_input, output_folder)

[ps_vector_phase1, ps_labels_phase1] = PosturalStabilityLateralExo135_octave(file_input, 1);
close all
[ps_vector_phase2, ps_labels_phase2] = PosturalStabilityLateralExo24_octave(file_input, 2);
close all
[ps_vector_phase3, ps_labels_phase3] = PosturalStabilityLateralExo135_octave(file_input, 3);
close all
[ps_vector_phase4, ps_labels_phase4] = PosturalStabilityLateralExo24_octave(file_input, 4);
close all
[ps_vector_phase5, ps_labels_phase5] = PosturalStabilityLateralExo135_octave(file_input, 5);
close all

filename = strcat(output_folder, "/", "PosturalStability_Lateral_Exo", ".yaml");
store_vector_of_vector_result(filename, ps_vector_phase1, ps_vector_phase2, ps_vector_phase3, ps_vector_phase4, ps_vector_phase5, [], ps_labels_phase1, ps_labels_phase2, ps_labels_phase3, ps_labels_phase4, ps_labels_phase5, []);
endfunction