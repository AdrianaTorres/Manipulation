#!/usr/bin/octave -qf

printf ("current directory: %s\n", pwd())
addpath("Performance_Time_octave/src")
addpath("Tools/src")

arg_list = argv ();
if nargin != 2
  printf ("ERROR: There should be 2 args.\n")
  printf ("- a .mat file containing the information of the Sagittal Lifting\n")
  printf ("- name of an existing folder where results should be stored.\n");
  printf ("Usage:\n");
  printf ("\t./run_pi_PerformanceTime_SagittalLifting data_SagittalLifting.mat result_dir\n\n");
  exit(127);
endif

printf ("Sagittal Lifting data mat : %s\n", arg_list{1});
printf ("result dir: %s\n", arg_list{2});

Main_Time_SagittalLifting_octave(arg_list{1}, arg_list{2})