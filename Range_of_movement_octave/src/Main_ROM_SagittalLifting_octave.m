function Main_ROM_SagittalLifting_octave(file_input, output_folder)

#Calculation of the Range of Movement for the Sagittal Lifting task
[labels_Ankle, ROM_Ankle_vector] = ROM_Ankle_octave(file_input);
close all
[labels_Elbow, ROM_Elbow_vector] = ROM_Elbow_octave(file_input);
close all
[labels_Hip, ROM_Hip_vector] = ROM_Hip_octave(file_input);
close all
[labels_Knee, ROM_Knee_vector] = ROM_Knee_octave(file_input);
close all
[labels_Shoulder, ROM_Shoulder_vector] = ROM_Shoulder_octave(file_input);
close all
[labels_Spine, ROM_Spine_vector] = ROM_Spine_octave(file_input);
close all

filename = strcat(output_folder, "/", "RangeOfMovement_SagittalLifting", ".yaml");
range_of_movement = store_vector_of_vector_result(filename, ROM_Ankle_vector, ROM_Elbow_vector, ROM_Hip_vector, ...
                                                  ROM_Knee_vector, ROM_Shoulder_vector, ROM_Spine_vector, ...
                                                  labels_Ankle, labels_Elbow, labels_Hip, labels_Knee, labels_Shoulder, labels_Spine);
                                                  
endfunction