#!/bin/bash
#  Batch script for mpirun job on cbio LSF cluster
#  Adjust your script as needed for your clusters!
#
# walltime : maximum wall clock time (hh:mm)
#BSUB -W 24:00
#
# Set Output file
#BSUB -o  p-xylene-explicit.%J.log
#
# Specify node group
#BSUB -m ls-gpu
#
# Specify the correct queue to use GPU's
#BSUB -q gpuqueue
#
# nodes: number of nodes and GPU request, 4 CPU and 4 GPU
#BSUB -n 4 -R "rusage[mem=8] span[ptile=4]"
#BSUB -gpu "num=1:j_exclusive=yes:mode=shared"
#
# job name (default = name of script file)
#BSUB -J " p-xylene-explicit"


# Run the simulation with verbose output:
echo "Running simulation via MPI..."
export PREFIX="p-xylene-explicit"
build_mpirun_configfile --configfilepath $PREFIX.configfile "yank script --yaml=$PREFIX.yaml"
mpiexec.hydra -configfile $PREFIX.configfile
date

