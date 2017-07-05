# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/netolo/DC/P06/projects/DC_P06.cache/wt [current_project]
set_property parent.project_path /home/netolo/DC/P06/projects/DC_P06.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/netolo/DC/P06/projects/DC_P06.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib /home/netolo/DC/P06/vhdl_files/run_length_encoder.vhd
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top run_length_encoder -part xc7z010clg400-1


write_checkpoint -force -noxdef run_length_encoder.dcp

catch { report_utilization -file run_length_encoder_utilization_synth.rpt -pb run_length_encoder_utilization_synth.pb }
