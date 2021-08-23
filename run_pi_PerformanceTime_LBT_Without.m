#!/usr/bin/octave -qf

printf ("current directory: %s\n", pwd())
addpath("Performance_Time_octave/src")
addpath("Tools/src")

arg_list = argv ();
if nargin != 2
  printf ("ERROR: There should be 2 args.\n")
  printf ("- a .mat file containing the information of the Lateral Box Transfer task without Exoskeleton\n")
  printf ("- name of an existing folder where results should be stored.\n");
  printf ("Usage:\n");
  printf ("\t./run_pi_PerformanceTime_LBT_Without data_LBT_Without.mat result_dir\n\n");
  exit(127);
endif

printf ("LBT data Without mat : %s\n", arg_list{1});
printf ("result dir: %s\n", arg_list{2});

Main_Time_LBT_Without_octave(arg_list{1}, arg_list{2})