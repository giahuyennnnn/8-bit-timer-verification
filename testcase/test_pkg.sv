package test_pkg;

  import timer_pkg::*;
  `include "base_test.sv" 
  
  `include "default_value_register_test.sv" 
  `include "rw_value_register_test.sv" 
  `include "rst_test.sv" 
  `include "reserved_test.sv" 
  
  `include "count_up_no_div_test.sv" 
  `include "count_up_div_2_test.sv" 
  `include "count_up_div_4_test.sv" 
  `include "count_up_div_8_test.sv" 
  
  `include "count_down_no_div_test.sv" 
  `include "count_down_div_2_test.sv" 
  `include "count_down_div_4_test.sv" 
  `include "count_down_div_8_test.sv" 
  
  `include "count_up_load_no_div_test.sv" 
  `include "count_up_load_div_2_test.sv" 
  `include "count_up_load_div_4_test.sv" 
  `include "count_up_load_div_8_test.sv" 
  
  `include "count_down_load_no_div_test.sv" 
  `include "count_down_load_div_2_test.sv" 
  `include "count_down_load_div_4_test.sv" 
  `include "count_down_load_div_8_test.sv" 
  
  `include "pause_up_test.sv" 
  `include "pause_down_test.sv" 
  `include "TSR_test.sv" 
  `include "TSR_int_test.sv" 
endpackage
