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
ExecStep $xv_path/bin/xelab -wto 518d5e11f5c042ec85026e2326fd2411 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot sim_run_length_encoder_behav xil_defaultlib.sim_run_length_encoder -log elaborate.log
