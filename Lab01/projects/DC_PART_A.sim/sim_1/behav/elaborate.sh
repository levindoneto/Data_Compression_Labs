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
ExecStep $xv_path/bin/xelab -wto b2ec5f06a93a47c38e2bbd6e59c2873e -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot sim1_parta_behav xil_defaultlib.sim1_parta -log elaborate.log
