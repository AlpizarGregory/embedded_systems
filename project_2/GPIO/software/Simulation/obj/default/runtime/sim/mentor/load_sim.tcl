# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force C:/NiosProject/software/Simulation/mem_init/hdl_sim/BasicNIOS_RAM.dat ./ 
file copy -force C:/NiosProject/software/Simulation/mem_init/BasicNIOS_RAM.hex ./ 
