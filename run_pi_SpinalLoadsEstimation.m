#!/usr/bin/octave -qf

printf ("current directory: %s\n", pwd())
addpath("Spinal_Loads_Estimation_octave/src")
addpath("Tools/src")

arg_list = argv ();
if nargin != 3
  printf ("ERROR: There should be 3 args.\n")
  printf ("- a .mat file containing the information of the Spinal load\n")
  printf ("- string related to the type of experiment [exo, no-exo, sagittal].\n");
  printf ("- name of an existing folder where results should be stored.\n");
  printf ("Usage:\n");
  printf ("\t./run_pi_SpinalLoadsEstimation data_SpinalLoad.mat [exo, no-exo, sagittal] result_dir\n\n");
  exit(127);
endif

printf ("Spinal Load data mat : %s\n", arg_list{1});
printf ("Mode : %s\n", arg_list{2});
printf ("result dir: %s\n", arg_list{3});

Main_SpinalLoadsEstim_octave(arg_list{1}, arg_list{3}, arg_list{2})
