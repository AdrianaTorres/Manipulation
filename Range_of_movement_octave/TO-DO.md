Revise max & min calculation

------------
1. It is necessary to add as an input variable to each ROM function the path of the file to be analysed
2. When the code is free of errors, the function "store_vector_of_vectors" should take 12 inputs (6 data + 6 labels)
3. Are the plots necessary, or can be deleted from the code?

Errors found: 
	- ROM_Spine_octave.m - line 57: 'minPeakProminence' is not an argument of the function. 
					alternatives can be found at: https://octave.sourceforge.io/signal/function/findpeaks.html
	- ROMAnkle_LBTWithout_octave_error.m - line 350: Variable RAnkleAngles_x(i). Index is out of range. 
							i takes the value 1177 and the size of the vector is 1176. This error appears again in further lines. 
	- ROMHip_LBTWithout_octave_error.m - line 349: Same error as before
	- ROMShoulder_LBTWithout_octave_error.m - line 354: Same error as before