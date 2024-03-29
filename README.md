# Manipulation Tasks Performance indicators

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0).

Copyright CSIC 2020

## Purposes

This toolbox allows computing Performance Indicator (PI) within the Manipulation Tasks project protocol.
In particular, Range of Movement (RoM), Postural Stability (PS), Performance Time (PT), Spinal Loads Estimation and Movement Smoothness can be computed.

## Installation

THIS INFORMATION SHOULD BE ADDED

Software requirements:

* `octave` version >= 5.2.0
* octave packages:
  * `control` >= 3.2.0
  * `signal` >= 1.4.1
  * `matgeom` >= 1.2.2
  * `geometry` >= 4.0.0

## Usage

### from Octave

If octave is opened from the repository root, assuming we created before a folder named `output`:

```octave
addpath("Range_of_movement_octave/src")
addpath("Postural_Stability_octave/src")
addpath("Performance_Time_octave/src")
addpath("Tools/src")
# For the Range of Movement computation of the Lateral Box Transfer task With Exoskeleton
Main_ROM_LBT_Exo('Range_of_movement_octave/tests/data/input/dinamica56_B.mat', "output")

# For the Range of Movement computation of the Lateral Box Transfer task Without Exoskeleton
Main_ROM_LBT_Without('Range_of_movement_octave/tests/data/input/dinamica42_B.mat', "output")

# For the Range of Movement computation of the Sagittal Lifting task
Main_ROM_SagittalLifting_octave('Range_of_movement_octave/tests/data/input/dinamica44_B.mat', "output")

# For the Postural Stability computation of the Lateral Box Transfer task With Exoskeleton
Main_PosturalStability_Lateral_Exo('Postural_Stability_octave/tests/data/input/dinamica56_B.mat', "output")

# For the Postural Stability computation of the Lateral Box Transfer task Without Exoskeleton
Main_PosturalStability_Lateral_Without('Postural_Stability_octave/tests/data/input/dinamica08_B.mat', "output")

# For the Postural Stability computation of the Sagittal Lifting task
Main_PosturalStability_Sagittal('Postural_Stability_octave/tests/data/input/dinamica61_B.mat', "output")

# For the Performance Time computation of the Lateral Box Transfer task With Exoskeleton
Main_Time_LBT_Exo_octave('Performance_Time_octave/tests/data/input/dinamica56_B.mat', "output")

# For the Performance Time computation of the Lateral Box Transfer task Without Exoskeleton
Main_Time_LBT_Without_octave('Performance_Time_octave/tests/data/input/dinamica42_B.mat', "output")

# For the Performance Time computation of the Sagittal Lifting task
Main_Time_SagittalLifting_octave('Performance_Time_octave/tests/data/input/dinamica44_B.mat', "output")

# For the Smoothnes computation of the Sagittal Lifting task
Main_Time_Smoothness_octave('Smoothness_octave/tests/data/input/dinamica57_B.mat', "output")

# For the Spinal Loads computation of the Lateral Box Transfer task With Exoskeleton
Main_SpinalLoadsEstim_octave('Spinal_Loads_Estimation_octave/tests/data/input/dinamica56_B.mat', "output", "exo")

# For the Spinal Loads computation of the Lateral Box Transfer task Without Exoskeleton
Main_SpinalLoadsEstim_octave('Spinal_Loads_Estimation_octave/tests/data/input/dinamica42_B.mat', "output", "no-exo")

# For the Spinal Loads computation of the Sagittal Lifting Task
Main_SpinalLoadsEstim_octave('Spinal_Loads_Estimation_octave/tests/data/input/dinamica44_B.mat', "output", "sagittal")
```

### Using the scripts

From the repository root, assuming that folder `output` already exists:

```term
# for the Range of Movement of the LBT With Exoskeleton
./run_pi_RoM_LBT_Exo.m Range_of_movement_octave/tests/data/input/dinamica56_B.mat output

# for the Range of Movement of the LBT Without Exoskeleton
./run_pi_RoM_LBT_Without.m Range_of_movement_octave/tests/data/input/dinamica42_B.mat output

# for the Range of Movement of the Sagittal Lifting Task
./run_pi_RoM_SagittalLifting.m Range_of_movement_octave/tests/data/input/dinamica44_B.mat output
# for the Postural Stability of the LBT With Exoskeleton
./run_pi_PosturalStability_LBT_Exo.m Postural_Stability_octave/tests/data/input/dinamica56_B.mat output

# for the Postural Stability of the LBT Without Exoskeleton
./run_pi_PosturalStability_LBT_Without.m Postural_Stability_octave/tests/data/input/dinamica08_B.mat output

# for the Postural Stability of the Sagittal Lifting Task
./run_pi_PosturalStability_SagittalLifting.m Postural_Stability_octave/tests/data/input/dinamica61_B.mat output

# for the Performance Time of the LBT With Exoskeleton
./run_pi_PerformanceTime_LBT_Exo.m Performance_Time_octave/tests/data/input/dinamica56_B.mat output

# for the Performance Time of the LBT Without Exoskeleton
./run_pi_PerformanceTime_LBT_Without.m Performance_Time_octave/tests/data/input/dinamica42_B.mat output

# for the Performance Time of the Sagittal Lifting Task
./run_pi_PerformanceTime_SagittalLifting.m Performance_Time_octave/tests/data/input/dinamica44_B.mat output

# for the Smoothness of the Sagittal Lifting Task
./run_pi_Smoothness_SagittalLifting.m Smoothness_octave/tests/data/input/dinamica57_B.mat output

# for the Spinal Loads Estimation of the LBT With Exoskeleton
./run_pi_SpinalLoadsEstimation.m Spinal_Loads_Estimation_octave/tests/data/input/dinamica56_B.mat output exo

# for the Spinal Loads Estimation of the LBT Without Exoskeleton
./run_pi_SpinalLoadsEstimation.m Spinal_Loads_Estimation_octave/tests/data/input/dinamica42_B.mat output no-exo

# for the Spinal Loads Estimation of the Sagittal Lifting Task
./run_pi_SpinalLoadsEstimation.m Spinal_Loads_Estimation_octave/tests/data/input/dinamica44_B.mat output sagittal
```

### Docker image

_(only tested under linux)_

Run the following command in order to create the docker image:

```console
docker build . -t pi_csic_manip
```

Assuming data files have standardized names (see above), and folder `output` is already created (to contain output file):

```shell
# Range of Movement material
docker run --rm -v $PWD/Range_of_movement_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_RoM_SagittalLifting /in/dinamica44_B.mat /out
docker run --rm -v $PWD/Range_of_movement_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_RoM_LBT_Exo /in/dinamica56_B.mat /out
docker run --rm -v $PWD/Range_of_movement_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_RoM_LBT_Without /in/dinamica42_B.mat /out

# Postural stability
docker run --rm -v $PWD/Postural_Stability_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_PosturalStability_SagittalLifting /in/dinamica61_B.mat /out
docker run --rm -v $PWD/Postural_Stability_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_PosturalStability_LBT_Exo /in/dinamica56_B.mat /out
docker run --rm -v $PWD/Postural_Stability_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_PosturalStability_LBT_Without /in/dinamica08_B.mat /out

# Performance time

docker run --rm -v $PWD/Performance_Time_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_PerformanceTime_SagittalLifting /in/dinamica44_B.mat /out
docker run --rm -v $PWD/Performance_Time_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_PerformanceTime_LBT_Exo /in/dinamica56_B.mat /out
docker run --rm -v $PWD/Performance_Time_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_PerformanceTime_LBT_Without /in/dinamica42_B.mat /out

# Smoothness
docker run --rm -v $PWD/Smoothness_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_Smoothness_SagittalLifting /in/dinamica57_B.mat /out

# Spinal load
docker run --rm -v $PWD/Spinal_Loads_Estimation_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_SpinalLoadsEstimation /in/dinamica56_B.mat "exo" /out
docker run --rm -v $PWD/Spinal_Loads_Estimation_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_SpinalLoadsEstimation /in/dinamica42_B.mat "no-exo" /out
docker run --rm -v $PWD/Spinal_Loads_Estimation_octave/tests/data/input:/in -v $PWD/output:/out pi_csic_manip ./run_pi_SpinalLoadsEstimation /in/dinamica44_B.mat "sagittal" /out
```

## Testing

All scripts are provided with reference input and related output files.
Under linux, an automatic regression testing can be launched, making sure all scripts generate the recorded output files, given the recorded input files.

This is based on the [Eurobench docker testing tool](https://github.com/eurobench/docker_test).
The test plan, related to the script calls previously listed, is in file [test_plan.xml](test_plan.xml).

Assuming the docker image has been created using name `pi_csic_manip`, the testing can be launched locally using (`python3` is required):

```shell
# only done once
wget -O test_docker_call.py https://raw.githubusercontent.com/eurobench/docker_test/master/test_docker_call.py
export DOCKER_IMAGE='pi_csic_manip'
export TEST_PLAN='test_plan.xml'
python3 test_docker_call.py
```

If any of the scripts does not generate the expected output files, the python file will state it.
