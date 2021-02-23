# Manipulation Tasks Performance indicators

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0).

Copyright CSIC 2020

## Purposes

This toolbox allows computing Performance Indicator (PI) within the Manipulation Tasks project protocol.
In particular, Range of Movement (RoM), Postural Stability (PS), Performance Time (PT), Spinal Loads Estimation and Movement Smothness can be computed.

## Installation

THIS INFORMATION SHOULD BE ADDED

## Usage

### from Octave

If octave is opened from the repository root, assuming we created before a folder named `output`:

```octave
addpath("Range_of_movement_octave/src")
addpath("Tools/src")
# For the Range of Movement computation of the Lateral Box Transfer task With Exoskeleton
Main_ROM_LBT_Exo('Range_of_movement_octave/tests/data/input/dinamica56_B.mat')

# For the Range of Movement computation of the Lateral Box Transfer task Without Exoskeleton
Main_ROM_LBT_Without()

# For the Range of Movement computation of the Sagittal Lifting task 
Main_ROM_SagittalLifting_octave('Range_of_movement_octave/tests/data/input/Dinamica44_B.mat', "output")
```

### Using the scripts

From the repository root, assuming that folder `output` already exists:

```term
# for the Range of Movement of the Sagittal Lifting Task
./run_pi_ROM_Sagittal ...
```
