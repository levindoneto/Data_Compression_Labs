#!/bin/bash

set -e

cd
rm -rf ~/DC/P02/projects
mkdir -p ~/DC/P02/projects
cd
. /usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/settings64.sh
cd
cd ./DC/P02
#vivado   -nojournal -nolog -notrace -source /usr/local.nfs/pas/teaching/ro2/VHDL_TASK2/part2/Skripte/simulation.tcl
vivado   -nojournal -nolog -notrace -source ./scripts/open_project_vivado.tcl
cd
