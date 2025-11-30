# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force C:/nios/software/audio_soc/mem_init/hdl_sim/audio_soc_RAM.dat ./ 
file copy -force C:/nios/software/audio_soc/mem_init/audio_soc_RAM.hex ./ 
