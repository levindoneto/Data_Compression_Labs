#!/bin/bash -f
xv_path="/usr/local.nfs/pas/sw/Xilinx/Vivado/2016.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim sim1_parta_behav -key {Behavioral:sim_1:Functional:sim1_parta} -tclbatch sim1_parta.tcl -view /home/netolo/DC/P01/PARTA/projects/sim1_parta_behav.wcfg -log simulate.log
