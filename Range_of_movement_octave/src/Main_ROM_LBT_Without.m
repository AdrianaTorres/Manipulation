function Main_ROM_LBT_Without(file_input, output_folder)
#Calculation of the Range of Movement for the LBT Task without Exo

##[labels_Ankle, ROM_Ankle_vector] = ROMAnkle_LBTWithout_octave_error(file_input);
##close all
[labels_Elbow, ROM_Elbow_vector] = ROMElbow_LBTWithout_octave(file_input);
close all
##[labels_Hip, ROM_Hip_vector] = ROMHip_LBTWithout_octave_error(file_input);
##close all
[labels_Knee, ROM_Knee_vector] = ROMKnee_LBTWithout_octave(file_input);
close all
##[labels_Shoulder, ROM_Shoulder_vector] = ROMShoulder_LBTWithout_octave_error();
##close all
[labels_Spine, ROM_Spine_vector] = ROMSpine_LBTWithout_octave(file_input);
close all

filename = strcat(output_folder, "/", "RangeOfMovement_LBT_noExo", ".yaml");
##range_of_movement = store_vector_of_vector_result(filename, ROM_Ankle_vector, ROM_Elbow_vector, ROM_Hip_vector, ...
##                                                  ROM_Knee_vector, ROM_Shoulder_vector, ROM_Spine_vector, ...
##                                                  labels_Ankle, labels_Elbow, labels_Hip, labels_Knee, labels_Shoulder);

range_of_movement = store_vector_of_vector_result(filename, ROM_Elbow_vector, ...
                                                  ROM_Knee_vector, ROM_Spine_vector, ...
                                                  labels_Elbow, labels_Knee, labels_Spine);
endfunction