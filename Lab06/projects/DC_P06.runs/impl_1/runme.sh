#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/usr/local.nfs/pas/sw/Xilinx/SDK/2016.4/bin:/usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/ids_lite/ISE/bin/lin64:/usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/bin
else
  PATH=/usr/local.nfs/pas/sw/Xilinx/SDK/2016.4/bin:/usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/ids_lite/ISE/bin/lin64:/usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/netolo/DC/P06/projects/DC_P06.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log run_length_encoder.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source run_length_encoder.tcl -notrace


