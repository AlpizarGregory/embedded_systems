
# (C) 2001-2025 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 18.1 625 win32 2025.12.02.00:08:57
# ----------------------------------------
# Auto-generated simulation script rivierapro_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     audio_soc_tb
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "aldec.do", and modify the text as directed.
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# set QSYS_SIMDIR <script generation output directory>
# #
# # Source the generated IP simulation script.
# source $QSYS_SIMDIR/aldec/rivierapro_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
# #
# # Call command to compile the Quartus EDA simulation library.
# dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
# com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #
# vlog -sv2k5 <your compilation options> <design and testbench files>
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
# set TOP_LEVEL_NAME <simulation top>
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
# elab
# #
# # Run the simulation.
# run
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If audio_soc_tb is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "audio_soc_tb"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "E:/quartus/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VHDL_COMPILE_OPTIONS] { 
  set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VERILOG_COMPILE_OPTIONS] { 
  set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sequencer_mem.hex ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_inst_ROM.hex ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_AC_ROM.hex ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_ociram_default_contents.hex ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_rf_ram_a.mif ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_ociram_default_contents.mif ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_ociram_default_contents.dat ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_rf_ram_b.dat ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_rf_ram_a.hex ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_rf_ram_b.mif ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_rf_ram_b.hex ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_rf_ram_a.dat ./
  file copy -force C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_RAM.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                       ./libraries/altera_ver           
vmap       altera_ver            ./libraries/altera_ver           
ensure_lib                       ./libraries/lpm_ver              
vmap       lpm_ver               ./libraries/lpm_ver              
ensure_lib                       ./libraries/sgate_ver            
vmap       sgate_ver             ./libraries/sgate_ver            
ensure_lib                       ./libraries/altera_mf_ver        
vmap       altera_mf_ver         ./libraries/altera_mf_ver        
ensure_lib                       ./libraries/altera_lnsim_ver     
vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver     
ensure_lib                       ./libraries/cyclonev_ver         
vmap       cyclonev_ver          ./libraries/cyclonev_ver         
ensure_lib                       ./libraries/cyclonev_hssi_ver    
vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver    
ensure_lib                       ./libraries/cyclonev_pcie_hip_ver
vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver
ensure_lib                                         ./libraries/altera_common_sv_packages              
vmap       altera_common_sv_packages               ./libraries/altera_common_sv_packages              
ensure_lib                                         ./libraries/error_adapter_0                        
vmap       error_adapter_0                         ./libraries/error_adapter_0                        
ensure_lib                                         ./libraries/border                                 
vmap       border                                  ./libraries/border                                 
ensure_lib                                         ./libraries/avalon_st_adapter                      
vmap       avalon_st_adapter                       ./libraries/avalon_st_adapter                      
ensure_lib                                         ./libraries/rsp_mux_003                            
vmap       rsp_mux_003                             ./libraries/rsp_mux_003                            
ensure_lib                                         ./libraries/rsp_mux_001                            
vmap       rsp_mux_001                             ./libraries/rsp_mux_001                            
ensure_lib                                         ./libraries/rsp_mux                                
vmap       rsp_mux                                 ./libraries/rsp_mux                                
ensure_lib                                         ./libraries/rsp_demux_006                          
vmap       rsp_demux_006                           ./libraries/rsp_demux_006                          
ensure_lib                                         ./libraries/rsp_demux_005                          
vmap       rsp_demux_005                           ./libraries/rsp_demux_005                          
ensure_lib                                         ./libraries/rsp_demux                              
vmap       rsp_demux                               ./libraries/rsp_demux                              
ensure_lib                                         ./libraries/cmd_mux_006                            
vmap       cmd_mux_006                             ./libraries/cmd_mux_006                            
ensure_lib                                         ./libraries/cmd_mux_005                            
vmap       cmd_mux_005                             ./libraries/cmd_mux_005                            
ensure_lib                                         ./libraries/cmd_mux_003                            
vmap       cmd_mux_003                             ./libraries/cmd_mux_003                            
ensure_lib                                         ./libraries/cmd_mux                                
vmap       cmd_mux                                 ./libraries/cmd_mux                                
ensure_lib                                         ./libraries/cmd_demux_003                          
vmap       cmd_demux_003                           ./libraries/cmd_demux_003                          
ensure_lib                                         ./libraries/cmd_demux_001                          
vmap       cmd_demux_001                           ./libraries/cmd_demux_001                          
ensure_lib                                         ./libraries/cmd_demux                              
vmap       cmd_demux                               ./libraries/cmd_demux                              
ensure_lib                                         ./libraries/RAM_s1_burst_adapter                   
vmap       RAM_s1_burst_adapter                    ./libraries/RAM_s1_burst_adapter                   
ensure_lib                                         ./libraries/hps_0_h2f_lw_axi_master_wr_limiter     
vmap       hps_0_h2f_lw_axi_master_wr_limiter      ./libraries/hps_0_h2f_lw_axi_master_wr_limiter     
ensure_lib                                         ./libraries/router_015                             
vmap       router_015                              ./libraries/router_015                             
ensure_lib                                         ./libraries/router_010                             
vmap       router_010                              ./libraries/router_010                             
ensure_lib                                         ./libraries/router_009                             
vmap       router_009                              ./libraries/router_009                             
ensure_lib                                         ./libraries/router_007                             
vmap       router_007                              ./libraries/router_007                             
ensure_lib                                         ./libraries/router_004                             
vmap       router_004                              ./libraries/router_004                             
ensure_lib                                         ./libraries/router_003                             
vmap       router_003                              ./libraries/router_003                             
ensure_lib                                         ./libraries/router_001                             
vmap       router_001                              ./libraries/router_001                             
ensure_lib                                         ./libraries/router                                 
vmap       router                                  ./libraries/router                                 
ensure_lib                                         ./libraries/AUDIO_avalon_audio_slave_agent_rsp_fifo
vmap       AUDIO_avalon_audio_slave_agent_rsp_fifo ./libraries/AUDIO_avalon_audio_slave_agent_rsp_fifo
ensure_lib                                         ./libraries/AUDIO_avalon_audio_slave_agent         
vmap       AUDIO_avalon_audio_slave_agent          ./libraries/AUDIO_avalon_audio_slave_agent         
ensure_lib                                         ./libraries/hps_0_h2f_lw_axi_master_agent          
vmap       hps_0_h2f_lw_axi_master_agent           ./libraries/hps_0_h2f_lw_axi_master_agent          
ensure_lib                                         ./libraries/NIOSII_data_master_agent               
vmap       NIOSII_data_master_agent                ./libraries/NIOSII_data_master_agent               
ensure_lib                                         ./libraries/AUDIO_avalon_audio_slave_translator    
vmap       AUDIO_avalon_audio_slave_translator     ./libraries/AUDIO_avalon_audio_slave_translator    
ensure_lib                                         ./libraries/NIOSII_data_master_translator          
vmap       NIOSII_data_master_translator           ./libraries/NIOSII_data_master_translator          
ensure_lib                                         ./libraries/hps_io                                 
vmap       hps_io                                  ./libraries/hps_io                                 
ensure_lib                                         ./libraries/fpga_interfaces                        
vmap       fpga_interfaces                         ./libraries/fpga_interfaces                        
ensure_lib                                         ./libraries/cpu                                    
vmap       cpu                                     ./libraries/cpu                                    
ensure_lib                                         ./libraries/reset_from_locked                      
vmap       reset_from_locked                       ./libraries/reset_from_locked                      
ensure_lib                                         ./libraries/audio_pll                              
vmap       audio_pll                               ./libraries/audio_pll                              
ensure_lib                                         ./libraries/rst_controller                         
vmap       rst_controller                          ./libraries/rst_controller                         
ensure_lib                                         ./libraries/irq_mapper                             
vmap       irq_mapper                              ./libraries/irq_mapper                             
ensure_lib                                         ./libraries/mm_interconnect_0                      
vmap       mm_interconnect_0                       ./libraries/mm_interconnect_0                      
ensure_lib                                         ./libraries/hps_0                                  
vmap       hps_0                                   ./libraries/hps_0                                  
ensure_lib                                         ./libraries/TIMER                                  
vmap       TIMER                                   ./libraries/TIMER                                  
ensure_lib                                         ./libraries/SEVEN_SEGMENTS                         
vmap       SEVEN_SEGMENTS                          ./libraries/SEVEN_SEGMENTS                         
ensure_lib                                         ./libraries/RAM                                    
vmap       RAM                                     ./libraries/RAM                                    
ensure_lib                                         ./libraries/NIOSII                                 
vmap       NIOSII                                  ./libraries/NIOSII                                 
ensure_lib                                         ./libraries/JTAG_UART                              
vmap       JTAG_UART                               ./libraries/JTAG_UART                              
ensure_lib                                         ./libraries/FIFO                                   
vmap       FIFO                                    ./libraries/FIFO                                   
ensure_lib                                         ./libraries/BUTTON_1                               
vmap       BUTTON_1                                ./libraries/BUTTON_1                               
ensure_lib                                         ./libraries/AUDIO_PLL                              
vmap       AUDIO_PLL                               ./libraries/AUDIO_PLL                              
ensure_lib                                         ./libraries/AUDIO_CONFIG                           
vmap       AUDIO_CONFIG                            ./libraries/AUDIO_CONFIG                           
ensure_lib                                         ./libraries/AUDIO                                  
vmap       AUDIO                                   ./libraries/AUDIO                                  
ensure_lib                                         ./libraries/audio_soc_inst_seven_segments_bfm      
vmap       audio_soc_inst_seven_segments_bfm       ./libraries/audio_soc_inst_seven_segments_bfm      
ensure_lib                                         ./libraries/audio_soc_inst_reset_bfm               
vmap       audio_soc_inst_reset_bfm                ./libraries/audio_soc_inst_reset_bfm               
ensure_lib                                         ./libraries/audio_soc_inst_memory_bfm              
vmap       audio_soc_inst_memory_bfm               ./libraries/audio_soc_inst_memory_bfm              
ensure_lib                                         ./libraries/audio_soc_inst_clk_bfm                 
vmap       audio_soc_inst_clk_bfm                  ./libraries/audio_soc_inst_clk_bfm                 
ensure_lib                                         ./libraries/audio_soc_inst_buttons_bfm             
vmap       audio_soc_inst_buttons_bfm              ./libraries/audio_soc_inst_buttons_bfm             
ensure_lib                                         ./libraries/audio_soc_inst_audio_config_bfm        
vmap       audio_soc_inst_audio_config_bfm         ./libraries/audio_soc_inst_audio_config_bfm        
ensure_lib                                         ./libraries/audio_soc_inst_audio_bfm               
vmap       audio_soc_inst_audio_bfm                ./libraries/audio_soc_inst_audio_bfm               
ensure_lib                                         ./libraries/audio_soc_inst                         
vmap       audio_soc_inst                          ./libraries/audio_soc_inst                         

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  eval vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                    -work altera_ver           
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                             -work lpm_ver              
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                -work sgate_ver            
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                            -work altera_mf_ver        
  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                        -work altera_lnsim_ver     
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                       -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                  -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"              -work cyclonev_pcie_hip_ver
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/verbosity_pkg.sv"                                                                                      -work altera_common_sv_packages              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/avalon_utilities_pkg.sv"                                                                               -work altera_common_sv_packages              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/avalon_mm_pkg.sv"                                                                                      -work altera_common_sv_packages              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"         -l altera_common_sv_packages -work error_adapter_0                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_mm_slave_bfm.sv"                                            -l altera_common_sv_packages -work border                                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_interrupt_sink.sv"                                          -l altera_common_sv_packages -work border                                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_clock_source.sv"                                            -l altera_common_sv_packages -work border                                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_reset_source.sv"                                            -l altera_common_sv_packages -work border                                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_hps_0_hps_io_border_memory.sv"                                  -l altera_common_sv_packages -work border                                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_hps_0_hps_io_border.sv"                                         -l altera_common_sv_packages -work border                                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_avalon_st_adapter.v"                                                       -work avalon_st_adapter                      
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_rsp_mux_003.sv"                               -l altera_common_sv_packages -work rsp_mux_003                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work rsp_mux_003                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_rsp_mux_001.sv"                               -l altera_common_sv_packages -work rsp_mux_001                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work rsp_mux_001                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_rsp_mux.sv"                                   -l altera_common_sv_packages -work rsp_mux                                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work rsp_mux                                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_rsp_demux_006.sv"                             -l altera_common_sv_packages -work rsp_demux_006                          
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_rsp_demux_005.sv"                             -l altera_common_sv_packages -work rsp_demux_005                          
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_rsp_demux.sv"                                 -l altera_common_sv_packages -work rsp_demux                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_cmd_mux_006.sv"                               -l altera_common_sv_packages -work cmd_mux_006                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work cmd_mux_006                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_cmd_mux_005.sv"                               -l altera_common_sv_packages -work cmd_mux_005                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work cmd_mux_005                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_cmd_mux_003.sv"                               -l altera_common_sv_packages -work cmd_mux_003                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work cmd_mux_003                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_cmd_mux.sv"                                   -l altera_common_sv_packages -work cmd_mux                                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work cmd_mux                                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_cmd_demux_003.sv"                             -l altera_common_sv_packages -work cmd_demux_003                          
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_cmd_demux_001.sv"                             -l altera_common_sv_packages -work cmd_demux_001                          
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_cmd_demux.sv"                                 -l altera_common_sv_packages -work cmd_demux                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter.sv"                                           -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                    -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter_13_1.sv"                                      -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter_new.sv"                                       -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_incr_burst_converter.sv"                                           -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_wrap_burst_converter.sv"                                           -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_default_burst_converter.sv"                                        -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_address_alignment.sv"                                       -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_st_pipeline_stage.sv"                                       -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_st_pipeline_base.v"                                         -l altera_common_sv_packages -work RAM_s1_burst_adapter                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_traffic_limiter.sv"                                         -l altera_common_sv_packages -work hps_0_h2f_lw_axi_master_wr_limiter     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_reorder_memory.sv"                                          -l altera_common_sv_packages -work hps_0_h2f_lw_axi_master_wr_limiter     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_sc_fifo.v"                                                  -l altera_common_sv_packages -work hps_0_h2f_lw_axi_master_wr_limiter     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_st_pipeline_base.v"                                         -l altera_common_sv_packages -work hps_0_h2f_lw_axi_master_wr_limiter     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router_015.sv"                                -l altera_common_sv_packages -work router_015                             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router_010.sv"                                -l altera_common_sv_packages -work router_010                             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router_009.sv"                                -l altera_common_sv_packages -work router_009                             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router_007.sv"                                -l altera_common_sv_packages -work router_007                             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router_004.sv"                                -l altera_common_sv_packages -work router_004                             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router_003.sv"                                -l altera_common_sv_packages -work router_003                             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router_001.sv"                                -l altera_common_sv_packages -work router_001                             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0_router.sv"                                    -l altera_common_sv_packages -work router                                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_sc_fifo.v"                                                                               -work AUDIO_avalon_audio_slave_agent_rsp_fifo
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_slave_agent.sv"                                             -l altera_common_sv_packages -work AUDIO_avalon_audio_slave_agent         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_uncompressor.sv"                                      -l altera_common_sv_packages -work AUDIO_avalon_audio_slave_agent         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_axi_master_ni.sv"                                           -l altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent          
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_address_alignment.sv"                                       -l altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent          
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_master_agent.sv"                                            -l altera_common_sv_packages -work NIOSII_data_master_agent               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_slave_translator.sv"                                        -l altera_common_sv_packages -work AUDIO_avalon_audio_slave_translator    
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_master_translator.sv"                                       -l altera_common_sv_packages -work NIOSII_data_master_translator          
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_hps_0_hps_io.v"                                                                              -work hps_io                                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram.v"                                                                                           -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_phy_csr.sv"                                                  -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_slave_translator.sv"                                        -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_avalon_st_adapter_error_adapter_0.sv"         -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/alt_mem_if_ddr3_mem_model_top_ddr3_mem_if_dm_pins_en_mem_if_dqsn_en.sv"   -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_clock_source.sv"                                            -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_altdqdqs.v"                                                                               -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter_13_1.sv"                                      -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_st_pipeline_base.v"                                                                      -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1.v"                                                                         -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/aldec/hps_hmctl.v"                                                                                     -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_sequencer_cpu_cv_sim_cpu_inst_test_bench.v"                                              -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter.sv"                                           -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_hps_memory_controller_top.sv"                               -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_rsp_mux.sv"                                   -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_generic_ddio.v"                                                                           -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_2.v"                                                                         -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_avalon_st_adapter.v"                                                       -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_default_burst_converter.sv"                                        -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_router_003.sv"                                -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_incr_burst_converter.sv"                                           -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_cmd_mux.sv"                                   -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_reset_sync.v"                                                                             -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/alt_mem_if_common_ddr_mem_model_ddr3_mem_if_dm_pins_en_mem_if_dqsn_en.sv" -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0.sv"                                                          -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                    -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_dll_cyclonev.sv"                                            -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_master_agent.sv"                                            -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_wrap_burst_converter.sv"                                           -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_adapter_new.sv"                                       -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_avalon_mm_clock_crossing_bridge.v"                                                      -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_scc_reg_file.v"                                                                                -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_master_agent.v"                                                                  -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_avalon_st_pipeline_base.v"                                                              -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_cmd_xbar_demux_001.v"                                                                          -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_trk_mgr.v"                                                                                     -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_reg_file.v"                                                                                    -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq.v"                                                                                             -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_scc_hhp_wrapper.v"                                                                             -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_addr_router_001.v"                                                                             -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_rsp_xbar_mux.v"                                                                                -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_cmd_xbar_mux.v"                                                                                -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_id_router.v"                                                                                   -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_rsp_xbar_demux.v"                                                                              -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_id_router_default_decode.v"                                                                    -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_mem_if_simple_avalon_mm_bridge.v"                                                       -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_hhp_apb2avalon_bridge.v"                                                                -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_arb_adder.v"                                                                     -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_addr_router_001_default_decode.v"                                                              -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_burst_uncompressor.v"                                                            -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_scc_hhp_phase_decode.v"                                                                        -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_addr_router.v"                                                                                 -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_avalon_sc_fifo.v"                                                                       -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_scc_mgr.v"                                                                                     -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_avalon_mm_bridge.v"                                                                     -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_slave_agent.v"                                                                   -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_master_translator.v"                                                             -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_cmd_xbar_demux.v"                                                                              -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_avalon_dc_fifo.v"                                                                       -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_slave_translator.v"                                                              -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_traffic_limiter.v"                                                               -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_altera_merlin_arbitrator.v"                                                                    -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_hhp_decompress_avl_mm_bridge.v"                                                                -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq/seq_addr_router_default_decode.v"                                                                  -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_acv_hard_io_pads.v"                                                                       -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_sc_fifo.v"                                                                               -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_reset_source.sv"                                            -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_master_translator.sv"                                       -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_slave_agent.sv"                                             -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_sequencer_mem_no_ifdef_params.sv"                           -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_iss_probe.v"                                                                              -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altdq_dqs2_acv_connect_to_hard_phy_cyclonev.sv"                           -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_router_001.sv"                                -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_acv_hard_memphy.v"                                                                        -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_address_alignment.sv"                                       -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_arbitrator.sv"                                              -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_cmd_mux_001.sv"                               -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_pll.sv"                                                         -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_avalon2apb_bridge.sv"                                       -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_hhp_qseq_top.v"                                                                          -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_acv_hard_addr_cmd_pads.v"                                                                 -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_cmd_demux.sv"                                 -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_irq_mapper.sv"                                                  -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_st_pipeline_stage.sv"                                       -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_router.sv"                                    -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_oct_cyclonev.sv"                                            -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_merlin_burst_uncompressor.sv"                                      -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_mem_if_sequencer_cpu_cv_sim_cpu_inst.v"                                                         -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_reset.v"                                                                                  -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_clock_pair_generator.v"                                                                   -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_rsp_mux_001.sv"                               -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_p0_acv_ldc.v"                                                                                -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_cmd_demux_001.sv"                             -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq_lib/hmctl_synchronizer.v"                                                                          -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq_lib/alt_mem_ddrx_buffer.v"                                                                         -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/seq_lib/alt_mem_ddrx_fifo.v"                                                                           -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/hps_sdram_mm_interconnect_1_router_002.sv"                                -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_mm_slave_bfm.sv"                                            -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/questa_mvc_svapi.svh"                                                     -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/mgc_common_axi.sv"                                                        -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/mgc_axi_master.sv"                                                        -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/mgc_axi_slave.sv"                                                         -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_interrupt_sink.sv"                                          -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_hps_0_fpga_interfaces_h2f_mpu_events.sv"                        -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_hps_0_fpga_interfaces.sv"                                       -l altera_common_sv_packages -work fpga_interfaces                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu.v"                                                                                -work cpu                                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_debug_slave_sysclk.v"                                                             -work cpu                                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_debug_slave_tck.v"                                                                -work cpu                                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_test_bench.v"                                                                     -work cpu                                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII_cpu_debug_slave_wrapper.v"                                                            -work cpu                                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_avalon_reset_from_locked_signal.v"                                                           -work reset_from_locked                      
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_AUDIO_PLL_audio_pll.vo"                                                                      -work audio_pll                              
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_reset_controller.v"                                                                             -work rst_controller                         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_reset_synchronizer.v"                                                                           -work rst_controller                         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_irq_mapper.sv"                                                  -l altera_common_sv_packages -work irq_mapper                             
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_mm_interconnect_0.v"                                                                         -work mm_interconnect_0                      
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_hps_0.v"                                                                                     -work hps_0                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_TIMER.v"                                                                                     -work TIMER                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_SEVEN_SEGMENTS.v"                                                                            -work SEVEN_SEGMENTS                         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_RAM.v"                                                                                       -work RAM                                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_NIOSII.v"                                                                                    -work NIOSII                                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_JTAG_UART.v"                                                                                 -work JTAG_UART                              
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_FIFO.v"                                                                                      -work FIFO                                   
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_BUTTON_1.v"                                                                                  -work BUTTON_1                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_AUDIO_PLL.v"                                                                                 -work AUDIO_PLL                              
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_serial_bus_controller.v"                                                           -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_slow_clock_generator.v"                                                                      -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init.v"                                                                       -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_dc2.v"                                                                   -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_d5m.v"                                                                   -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_lcm.v"                                                                   -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ltm.v"                                                                   -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ob_de1_soc.v"                                                            -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ob_de2_115.v"                                                            -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ob_de2i_150.v"                                                           -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ob_de10_standard.v"                                                      -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ob_audio.v"                                                              -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ob_adv7180.v"                                                            -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_av_config_auto_init_ob_adv7181.v"                                                            -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_AUDIO_CONFIG.v"                                                                              -work AUDIO_CONFIG                           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_audio_bit_counter.v"                                                                         -work AUDIO                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_audio_in_deserializer.v"                                                                     -work AUDIO                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_audio_out_serializer.v"                                                                      -work AUDIO                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_clock_edge.v"                                                                                -work AUDIO                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_up_sync_fifo.v"                                                                                 -work AUDIO                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc_AUDIO.v"                                                                                     -work AUDIO                                  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_conduit_bfm_0005.sv"                                               -l altera_common_sv_packages -work audio_soc_inst_seven_segments_bfm      
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_reset_source.sv"                                            -l altera_common_sv_packages -work audio_soc_inst_reset_bfm               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_conduit_bfm_0004.sv"                                               -l altera_common_sv_packages -work audio_soc_inst_memory_bfm              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_avalon_clock_source.sv"                                            -l altera_common_sv_packages -work audio_soc_inst_clk_bfm                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_conduit_bfm_0003.sv"                                               -l altera_common_sv_packages -work audio_soc_inst_buttons_bfm             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_conduit_bfm_0002.sv"                                               -l altera_common_sv_packages -work audio_soc_inst_audio_config_bfm        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/altera_conduit_bfm.sv"                                                    -l altera_common_sv_packages -work audio_soc_inst_audio_bfm               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/submodules/audio_soc.v"                                                                                           -work audio_soc_inst                         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "C:/Users/camf/Downloads/embedded_systems-HPS_FPGA/project_2/Audio_soc/audio_soc/testbench/audio_soc_tb/simulation/audio_soc_tb.v"                                                                                                                                                
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter -L rsp_mux_003 -L rsp_mux_001 -L rsp_mux -L rsp_demux_006 -L rsp_demux_005 -L rsp_demux -L cmd_mux_006 -L cmd_mux_005 -L cmd_mux_003 -L cmd_mux -L cmd_demux_003 -L cmd_demux_001 -L cmd_demux -L RAM_s1_burst_adapter -L hps_0_h2f_lw_axi_master_wr_limiter -L router_015 -L router_010 -L router_009 -L router_007 -L router_004 -L router_003 -L router_001 -L router -L AUDIO_avalon_audio_slave_agent_rsp_fifo -L AUDIO_avalon_audio_slave_agent -L hps_0_h2f_lw_axi_master_agent -L NIOSII_data_master_agent -L AUDIO_avalon_audio_slave_translator -L NIOSII_data_master_translator -L hps_io -L fpga_interfaces -L cpu -L reset_from_locked -L audio_pll -L rst_controller -L irq_mapper -L mm_interconnect_0 -L hps_0 -L TIMER -L SEVEN_SEGMENTS -L RAM -L NIOSII -L JTAG_UART -L FIFO -L BUTTON_1 -L AUDIO_PLL -L AUDIO_CONFIG -L AUDIO -L audio_soc_inst_seven_segments_bfm -L audio_soc_inst_reset_bfm -L audio_soc_inst_memory_bfm -L audio_soc_inst_clk_bfm -L audio_soc_inst_buttons_bfm -L audio_soc_inst_audio_config_bfm -L audio_soc_inst_audio_bfm -L audio_soc_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter -L rsp_mux_003 -L rsp_mux_001 -L rsp_mux -L rsp_demux_006 -L rsp_demux_005 -L rsp_demux -L cmd_mux_006 -L cmd_mux_005 -L cmd_mux_003 -L cmd_mux -L cmd_demux_003 -L cmd_demux_001 -L cmd_demux -L RAM_s1_burst_adapter -L hps_0_h2f_lw_axi_master_wr_limiter -L router_015 -L router_010 -L router_009 -L router_007 -L router_004 -L router_003 -L router_001 -L router -L AUDIO_avalon_audio_slave_agent_rsp_fifo -L AUDIO_avalon_audio_slave_agent -L hps_0_h2f_lw_axi_master_agent -L NIOSII_data_master_agent -L AUDIO_avalon_audio_slave_translator -L NIOSII_data_master_translator -L hps_io -L fpga_interfaces -L cpu -L reset_from_locked -L audio_pll -L rst_controller -L irq_mapper -L mm_interconnect_0 -L hps_0 -L TIMER -L SEVEN_SEGMENTS -L RAM -L NIOSII -L JTAG_UART -L FIFO -L BUTTON_1 -L AUDIO_PLL -L AUDIO_CONFIG -L AUDIO -L audio_soc_inst_seven_segments_bfm -L audio_soc_inst_reset_bfm -L audio_soc_inst_memory_bfm -L audio_soc_inst_clk_bfm -L audio_soc_inst_buttons_bfm -L audio_soc_inst_audio_config_bfm -L audio_soc_inst_audio_bfm -L audio_soc_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                                         -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                                           -- Compile device library files"
  echo
  echo "com                                               -- Compile the design files in correct order"
  echo
  echo "elab                                              -- Elaborate top level design"
  echo
  echo "elab_debug                                        -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                                                -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                                          -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                                    -- Top level module name."
  echo "                                                     For most designs, this should be overridden"
  echo "                                                     to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME                              -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                                       -- Platform Designer base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR                               -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS                      -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS                         -- User-defined elaboration options, added to elab/elab_debug aliases."
  echo
  echo "USER_DEFINED_VHDL_COMPILE_OPTIONS                 -- User-defined vhdl compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_VERILOG_COMPILE_OPTIONS              -- User-defined verilog compile options, added to com/dev_com aliases."
}
file_copy
h
