class pause_up_test extends base_test;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	write(8'h03,8'h01);
	write(8'h00,8'h01);
        repeat(200)@(posedge dut_vif.ker_clk);
	write(8'h00,8'h00);
        repeat(200)@(posedge dut_vif.ker_clk);
	read(8'h01,rdata);
	if(rdata != 0 || dut_vif.interrupt != 0)begin
		$display("%0t: [pause up] interrupt or TSR is set while the counter is paused",$time);
		error_cnt++;
	end
	write(8'h00,8'h01);

        repeat(70)@(posedge dut_vif.ker_clk);
	read(8'h01,rdata);
	if(rdata != 1 || dut_vif.interrupt != 1)begin
		$display("%0t: [pause up] interrupt or TSR is not set after resuming or the counter didn't continue from where it left ",$time);
		error_cnt++;
	end


	endtask
endclass
