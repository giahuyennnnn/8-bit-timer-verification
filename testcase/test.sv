class test extends base_test;
	function new();
		super.new();
	endfunction

	function void check(bit[7:0] addr, bit[7:0] data);
		if (data!=0) begin
			$display("%0t: [Default value register] Default value of 8'h%h is NOT matching",$time,addr);
			error_cnt++;
		end
		else 
			$display("%0t: [Default value register] Default value of 8'h%h is matching",$time,addr);
	endfunction
	virtual task run_scenario();
	write(8'h03,8'h03);
	write(8'h00,8'h01);
	repeat(248) @(posedge dut_vif.ker_clk);
	read(8'h01,rdata);
	if(dut_vif.interrupt == 0) $display("oh no");
	read(8'h01,rdata);
	if(dut_vif.interrupt == 1) $display("oh yeah");
	write(8'h01,8'h03);
	read(8'h01,rdata);
	if(dut_vif.interrupt == 0) $display("oh no");

	endtask
endclass
