proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  set_param xicom.use_bs_reader 1
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/BME/Desktop/lcd/lcd.cache/wt [current_project]
  set_property parent.project_path C:/Users/BME/Desktop/lcd/lcd.xpr [current_project]
  set_property ip_repo_paths c:/Users/BME/Desktop/lcd/lcd.cache/ip [current_project]
  set_property ip_output_repo c:/Users/BME/Desktop/lcd/lcd.cache/ip [current_project]
  add_files -quiet C:/Users/BME/Desktop/lcd/lcd.runs/synth_1/tft_char.dcp
  add_files -quiet C:/Users/BME/Desktop/lcd/lcd.runs/clk_wiz_0_synth_1/clk_wiz_0.dcp
  set_property netlist_only true [get_files C:/Users/BME/Desktop/lcd/lcd.runs/clk_wiz_0_synth_1/clk_wiz_0.dcp]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst c:/Users/BME/Desktop/lcd/lcd.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/BME/Desktop/lcd/lcd.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst c:/Users/BME/Desktop/lcd/lcd.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/BME/Desktop/lcd/lcd.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
  read_xdc -ref clk_wiz_0 -cells inst c:/Users/BME/Desktop/lcd/lcd.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc
  set_property processing_order EARLY [get_files c:/Users/BME/Desktop/lcd/lcd.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
  read_xdc C:/Users/BME/Desktop/Ä£µç2/DSDB.xdc
  link_design -top tft_char -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force tft_char_opt.dcp
  catch {report_drc -file tft_char_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force tft_char_placed.dcp
  catch { report_io -file tft_char_io_placed.rpt }
  catch { report_clock_utilization -file tft_char_clock_utilization_placed.rpt }
  catch { report_utilization -file tft_char_utilization_placed.rpt -pb tft_char_utilization_placed.pb }
  catch { report_control_sets -verbose -file tft_char_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force tft_char_routed.dcp
  catch { report_drc -file tft_char_drc_routed.rpt -pb tft_char_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file tft_char_timing_summary_routed.rpt -rpx tft_char_timing_summary_routed.rpx }
  catch { report_power -file tft_char_power_routed.rpt -pb tft_char_power_summary_routed.pb }
  catch { report_route_status -file tft_char_route_status.rpt -pb tft_char_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force tft_char.bit 
  if { [file exists C:/Users/BME/Desktop/lcd/lcd.runs/synth_1/tft_char.hwdef] } {
    catch { write_sysdef -hwdef C:/Users/BME/Desktop/lcd/lcd.runs/synth_1/tft_char.hwdef -bitfile tft_char.bit -meminfo tft_char.mmi -file tft_char.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

