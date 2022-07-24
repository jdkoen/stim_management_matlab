# Stimulus and Data Management for Matlab

## Purpose

This is a set of functions meant to help with managing stimuli and data storage for psychology and cognitive neuroscience experiments created with Matlab based experiment presentation programs, such as Psychtoolbox and Cogent 2000. 

## Installation

Clone or download the repository as a `.zip` file and add the folders with all sub-folders to your matlab path. 

## Overview

`create_stim_structure` can be used to create a `struct array` variable for storing stimulus and response data. `add_empty_stim_fields` adds new fields with 'empty' values, and `convert_stim_structure` converts the `struct array` created by `create_stim_structure` to a `cell array` to be saved as a `.csv` file. 

`psuedorandom_sequence`, `run_of_n`, `segment_list_by_row`, and `randomize_matrix` are useful for creating random stimulus lists. 

`logger` and the `ptb*` functions are wrappers of Psychtoolbox to be used in our labs setup. These may not work depending on versions and hardware in your lab. 


