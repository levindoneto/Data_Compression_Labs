#!/bin/bash

set -e

cd
rm -rf ~/DC/P01/PARTA/projects
mkdir -p ~/DC/P01/PARTA/projects
cd
. /usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/settings64.sh
cd
cd ./DC/P01/PARTA
#vivado   -nojournal -nolog -notrace -source /usr/local.nfs/pas/teaching/ro2/VHDL_TASK2/part2/Skripte/simulation.tcl
vivado   -nojournal -nolog -notrace -source ./scripts/open_project_parta.tcl
cd
