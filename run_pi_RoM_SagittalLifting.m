#!/usr/bin/octave -qf

printf ("current directory: %s\n", pwd())
addpath("Range_of_movement_octave/src")
addpath("Tools/src")

arg_list = argv ();
%arg_list = {'Range_of_movement_octave/tests/data/input/dinamica44_B.mat' 'out'};
if nargin != 2
  printf ("ERROR: There should be 2 args.\n")
  printf ("- a .mat file containing the information of the Sagittal Lifting task\n")
  printf ("- name of an existing folder where results should be stored.\n");
  printf ("Usage:\n");
  printf ("\t./run_pi_RoM_SagittalLifting data_sagittal.mat result_dir\n\n");
  exit(127);
endif

printf ("Sagittal Lifting mat : %s\n", arg_list{1});
printf ("result dir: %s\n", arg_list{2});

Main_ROM_SagittalLifting_octave(arg_list{1}, arg_list{2})