class pause_down_test extends base_test;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	write(8'h03,8'h02);
	write(8'h02,8'hFF);
	write(8'h00,8'h04);
	write(8'h00,8'h03);
        repeat(200)@(posedge dut_vif.ker_clk);
	write(8'h00,8'h02);
        repeat(300)@(posedge dut_vif.ker_clk);
	read(8'h01,rdata);
	if(rdata != 0 || dut_vif.interrupt != 0)begin
		$display("%0t: [pause up] interrupt or TSR is set while the counter is paused",$time);
		error_cnt++;
	end
	write(8'h00,8'h03);

        repeat(70)@(posedge dut_vif.ker_clk);
	read(8'h01,rdata);
	if(rdata != 2 || dut_vif.interrupt != 1)begin
		$display("%0t: [pause up] interrupt or TSR is not set after resuming or the counter didn't continue from where it left ",$time);
		error_cnt++;
	end


	endtask
endclass
