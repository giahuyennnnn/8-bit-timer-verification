`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt));
 bit[7:0] internal_count;
 assign internal_count = u_dut.u_counter.cnt;

  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  // 50 MHz
  initial begin
    d_if.pclk = 0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    d_if.ker_clk = 1;
    forever begin 
      #2.5ns;
      d_if.ker_clk = ~d_if.ker_clk;
    end
  end

  initial begin
    #1ms;
    $display("[testbench] Time out..TEST FAILED..Seems your tb is hang!");
    $finish;
  end
base_test                      base = new();
//1
default_value_register_test    default_value_register = new();
rw_value_register_test         rw_value_register = new();
rst_test                       rst = new();
reserved_test                  reserved = new();
//2
count_up_no_div_test           count_up_no_div = new();
count_up_div_2_test            count_up_div_2 = new();
count_up_div_4_test            count_up_div_4 = new();
count_up_div_8_test            count_up_div_8 = new();
//
count_down_no_div_test         count_down_no_div = new();
count_down_div_2_test          count_down_div_2 = new();
count_down_div_4_test          count_down_div_4 = new();
count_down_div_8_test          count_down_div_8 = new();
//
count_up_load_no_div_test      count_up_load_no_div = new();
count_up_load_div_2_test       count_up_load_div_2 = new();
count_up_load_div_4_test       count_up_load_div_4 = new();
count_up_load_div_8_test       count_up_load_div_8 = new();
//
count_down_load_no_div_test    count_down_load_no_div = new();
count_down_load_div_2_test     count_down_load_div_2 = new();
count_down_load_div_4_test     count_down_load_div_4 = new();
count_down_load_div_8_test     count_down_load_div_8 = new();
//
pause_up_test                  pause_up = new();
pause_down_test                pause_down = new();
//
TSR_test                       TSR_t = new();
TSR_int_test                   TSR_int = new();

initial begin
	if($test$plusargs("default_value_register_test"))begin
        	$display("[TestBench]default_value_register");
        	base = default_value_register;
	end
	else if($test$plusargs("rw_value_register_test"))begin
       		 $display("[TestBench] rw_value_register");
        	base = rw_value_register;
	end
	else if($test$plusargs("rst_test"))begin
       		 $display("[TestBench] rst");
        	base = rst;
	end
	else if($test$plusargs("reserved_test"))begin
       		 $display("[TestBench] reserved");
        	base = reserved;
	end
	else if($test$plusargs("count_up_no_div_test"))begin
       		 $display("[TestBench] count_up_no_div");
        	base = count_up_no_div;
	end
	else if($test$plusargs("count_up_div_2_test"))begin
       		 $display("[TestBench] count_up_div_2");
        	base = count_up_div_2;
	end
	else if($test$plusargs("count_up_div_4_test"))begin
       		 $display("[TestBench] count_up_div_4");
        	base = count_up_div_4;
	end
	else if($test$plusargs("count_up_div_8_test"))begin
       		 $display("[TestBench] count_up_div_8");
        	base = count_up_div_8;
	end
	else if($test$plusargs("count_down_no_div_test"))begin
       		 $display("[TestBench] count_down_no_div");
        	base = count_down_no_div;
	end
	else if($test$plusargs("count_down_div_2_test"))begin
       		 $display("[TestBench] count_down_div_2");
        	base = count_down_div_2;
	end
	else if($test$plusargs("count_down_div_4_test"))begin
       		 $display("[TestBench] count_down_div_4");
        	base = count_down_div_4;
	end
	else if($test$plusargs("count_down_div_8_test"))begin
       		 $display("[TestBench] count_down_div_8");
        	base = count_down_div_8;
	end
	else if($test$plusargs("count_up_load_no_div_test"))begin
       		 $display("[TestBench] count_up_load_no_div");
        	base = count_up_load_no_div;
	end
	else if($test$plusargs("count_up_load_div_2_test"))begin
       		 $display("[TestBench] count_up_load_div_2");
        	base = count_up_load_div_2;
	end
	else if($test$plusargs("count_up_load_div_4_test"))begin
       		 $display("[TestBench] count_up_load_div_4");
        	base = count_up_load_div_4;
	end
	else if($test$plusargs("count_up_load_div_8_test"))begin
       		 $display("[TestBench] count_up_load_div_8");
        	base = count_up_load_div_8;
	end
	else if($test$plusargs("count_down_load_no_div_test"))begin
       		 $display("[TestBench] count_down_load_no_div");
        	base = count_down_load_no_div;
	end
	else if($test$plusargs("count_down_load_div_2_test"))begin
       		 $display("[TestBench] count_down_load_div_2");
        	base = count_down_load_div_2;
	end
	else if($test$plusargs("count_down_load_div_4_test"))begin
       		 $display("[TestBench] count_down_load_div_4");
        	base = count_down_load_div_4;
	end
	else if($test$plusargs("count_down_load_div_8_test"))begin
       		 $display("[TestBench] count_down_load_div_8");
        	base = count_down_load_div_8;
	end
	else if($test$plusargs("pause_up_test"))begin
       		 $display("[TestBench] pause_up");
        	base = pause_up;
	end
	else if($test$plusargs("pause_down_test"))begin
       		 $display("[TestBench] pause_down");
        	base = pause_down;
	end
	else if($test$plusargs("TSR_test"))begin
       		 $display("[TestBench] TSR");
        	base = TSR_t;
	end
	else if($test$plusargs("TSR_int_test"))begin
       		 $display("[TestBench] TSR_int");
        	base = TSR_int;
	end

	base.dut_vif = d_if;
	base.run_test();
end	
endmodule
