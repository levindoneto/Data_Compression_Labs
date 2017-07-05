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
ExecStep $xv_path/bin/xsim sim_run_length_encoder_behav -key {Behavioral:sim_1:Functional:sim_run_length_encoder} -tclbatch sim_run_length_encoder.tcl -log simulate.log
