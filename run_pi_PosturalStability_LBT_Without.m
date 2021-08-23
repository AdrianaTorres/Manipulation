#!/usr/bin/octave -qf

printf ("current directory: %s\n", pwd())
addpath("Postural_Stability_octave/src")
addpath("Tools/src")

arg_list = argv ();
if nargin != 2
  printf ("ERROR: There should be 2 args.\n")
  printf ("- a .mat file containing the information of the Lateral Box Transfer task without Exoskeleton\n")
  printf ("- name of an existing folder where results should be stored.\n");
  printf ("Usage:\n");
  printf ("\t./run_pi_PosturalStability_LBT_Without data_LBT_Without.mat result_dir\n\n");
  exit(127);
endif

printf ("LBT data Wihtout mat : %s\n", arg_list{1});
printf ("result dir: %s\n", arg_list{2});

Main_PosturalStability_Lateral_Without(arg_list{1}, arg_list{2})