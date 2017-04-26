#!/bin/bash
set -e

cd
. /usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/settings64.sh
cd ./DC/P01/PARTA/sysgen
sysgen
