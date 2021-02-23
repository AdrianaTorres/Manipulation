#Calculation of the Range of Movement for the LBT Task with Exo
[labels_Ankle, ROM_Ankle_vector] = ROMAnkle_LBTExo_octave();
close all
[labels_Elbow, ROM_Elbow_vector] = ROMElbow_LBTExo_octave();
close all
[labels_Hip, ROM_Hip_vector] = ROMHip_LBTExo_octave();
close all
[labels_Knee, ROM_Knee_vector] = ROMKnee_LBTExo_octave();
close all
[labels_Shoulder, ROM_Shoulder_vector] = ROMShoulder_LBTExo_octave();
close all
[labels_Spine, ROM_Spine_vector] = ROMSpine_LBTExo_octave();
close all

filename = strcat("..", "/", "RangeOfMovement_LBT_Exo", ".yaml");
range_of_movement = store_vector_of_vector_result(filename, ROM_Ankle_vector, ROM_Elbow_vector, ROM_Hip_vector, ...
                                                  ROM_Knee_vector, ROM_Shoulder_vector, ROM_Spine_vector, ...
                                                  labels_Ankle, labels_Elbow, labels_Hip, labels_Knee, labels_Shoulder, labels_Spine);

##range_of_movement = store_vector_of_vector_result(filename, ROM_Elbow_vector, ...
##                                                  ROM_Knee_vector, ROM_Spine_vector, ...
##                                                  labels_Elbow, labels_Knee, labels_Spine);