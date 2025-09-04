class rst_test extends base_test;
	function new();
		super.new();
	endfunction

	function void check(bit[7:0] addr, bit[7:0] data);
		if (data!=0) begin
			$display("%0t: [Reset on the fly] Value of 8'h%h is INCORRECT",$time,addr);
			error_cnt++;
		end
		else 
			$display("%0t: [Reset on the fly] Value of 8'h%h is CORRECT",$time,addr);
	endfunction
	virtual task run_scenario();
		wait(dut_vif.presetn == 1'b1);
		write(8'h02,8'hFF);
		write(8'h03,8'h03);
		write(8'h00,8'h03);
		wait(dut_vif.interrupt == 1'b1);
		read(8'h01,rdata);
		if(rdata != 8'h02)begin
			$display("%0t: [Reset on the fly] TSR expected 8'h02 but got 8'h%h",$time,rdata);
			error_cnt++;
		end
		dut_vif.presetn = 0;
		#5;
		dut_vif.presetn = 1;

			$display("%0t: [Reset on the fly] Trigger reset",$time);
		for(bit [7:0] i = 0; i < 4; i++) begin
			@(posedge dut_vif.pclk);
			$display("%0t: Read value register",$time);
			read(i,rdata);
			check(i,rdata);
		end
		@(posedge dut_vif.pclk);
		@(posedge dut_vif.pclk);
		write(8'h00,8'h01);
		read(8'h00,rdata);
		if(rdata != 8'h01)begin
			$display("%0t: [Reset on the fly]ERROR after reset TCR expected 8'h01 but got 8'h%h",$time,rdata);
			error_cnt++;
		end
	endtask
endclass
