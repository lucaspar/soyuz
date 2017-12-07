set errorCount 0

project new ram_soyuz

project set "Manual Implementation Compile Order" true

project set family  spartan3e
project set device  xc3s500e
project set package fg320
project set speed   -5

if { ![xfile add "./ram_soyuz/doc/pg058-blk-mem-gen.pdf" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/doc/pg058-blk-mem-gen.pdf' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/doc/blk_mem_gen_v7_3_vinfo.html" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/doc/blk_mem_gen_v7_3_vinfo.html' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/blk_mem_gen_v7_3_readme.txt" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/blk_mem_gen_v7_3_readme.txt' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/example_design/ram_soyuz_exdes.ucf" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/example_design/ram_soyuz_exdes.ucf' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/example_design/ram_soyuz_exdes.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/example_design/ram_soyuz_exdes.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/example_design/ram_soyuz_exdes.xdc" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/example_design/ram_soyuz_exdes.xdc' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/example_design/ram_soyuz_prod.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/example_design/ram_soyuz_prod.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/implement/implement.bat" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/implement/implement.bat' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/implement/implement.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/implement/implement.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/implement/planAhead_ise.bat" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/implement/planAhead_ise.bat' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/implement/planAhead_ise.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/implement/planAhead_ise.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/implement/planAhead_ise.tcl" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/implement/planAhead_ise.tcl' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/implement/xst.prj" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/implement/xst.prj' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/implement/xst.scr" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/implement/xst.scr' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/addr_gen.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/addr_gen.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/bmg_stim_gen.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/bmg_stim_gen.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/bmg_tb_pkg.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/bmg_tb_pkg.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/checker.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/checker.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/data_gen.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/data_gen.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/simcmds.tcl" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/simcmds.tcl' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/simulate_isim.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/simulate_isim.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/simulate_mti.bat" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/simulate_mti.bat' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/simulate_mti.do" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/simulate_mti.do' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/simulate_mti.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/simulate_mti.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/simulate_ncsim.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/simulate_ncsim.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/simulate_vcs.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/simulate_vcs.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/ucli_commands.key" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/ucli_commands.key' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/vcs_session.tcl" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/vcs_session.tcl' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/wave_mti.do" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/wave_mti.do' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/functional/wave_ncsim.sv" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/functional/wave_ncsim.sv' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/ram_soyuz_synth.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/ram_soyuz_synth.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/ram_soyuz_tb.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/ram_soyuz_tb.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/random.vhd" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/random.vhd' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/simcmds.tcl" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/simcmds.tcl' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/simulate_isim.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/simulate_isim.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/simulate_mti.bat" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/simulate_mti.bat' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/simulate_mti.do" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/simulate_mti.do' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/simulate_mti.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/simulate_mti.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/simulate_ncsim.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/simulate_ncsim.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/simulate_vcs.sh" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/simulate_vcs.sh' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/ucli_commands.key" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/ucli_commands.key' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/vcs_session.tcl" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/vcs_session.tcl' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/wave_mti.do" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/wave_mti.do' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz/simulation/timing/wave_ncsim.sv" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz/simulation/timing/wave_ncsim.sv' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz.ngc" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz.ngc' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz.vho" -view implementation -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz.vho' to ISE project."
   incr errorCount
}
if { ![xfile add "./ram_soyuz.vhd" -view all -origin_type created] } {
   puts "ERROR: Failed to add './ram_soyuz.vhd' to ISE project."
   incr errorCount
}

project set top "ram_soyuz"

project set "Project Generator" CoreGen
project set "Implementation Stop View" Structural

project save
project close

exit $errorCount
