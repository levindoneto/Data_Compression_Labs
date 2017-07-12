create_project DC_P02 ./projects -part xc7z010clg400-1
add_files -norecurse [glob vhdl_files/run_length_encoder.vhd]
add_files -fileset sim_1 -norecurse ./vhdl_files/sim1_partb.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
#reset_run synth_1
#set_property -name {xsim.simulate.runtime} -value {100ns} -objects [get_filesets sim_1]
#launch_simulation
#restart
#run 10 ns
