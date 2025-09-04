class TSR_int_test  extends base_test;
	function new();
		super.new();
	endfunction
	function void check_int0();
		if(dut_vif.interrupt != 0)begin
			$display("interrupt trigger");
			error_cnt++;
		end
	endfunction
	function void check_int1();
		if(dut_vif.interrupt != 1)begin
			$display("interrupt not set");
			error_cnt++;
		end
	endfunction
	virtual task run_scenario();
	bit[7:0] rand_data;
		wait(dut_vif.presetn == 1'b1);
		//up
		write(8'h01, 8'h03);
		write(8'h03,8'h03);
		read(8'h01, rdata);
		if(rdata != 0)begin
			$display("%0t: [TSR test] TSR is not reset", $time);
			error_cnt++;
		end
		write(8'h00,8'h01);
		repeat(248) @(posedge dut_vif.ker_clk);
		read(8'h01,rdata);
		if (rdata != 8'h00)begin
			$display("%0t: [TSR test] TSR rise soon", $time);
			error_cnt++;
		end
		check_int0();
		
		read(8'h01,rdata);
		if (rdata != 8'h01)begin
			$display("%0t: [TSR test] TSR is not set", $time);
			error_cnt++;
		end
		check_int1();

		//down
		write(8'h00,8'h00);
		write(8'h01,8'h03);
		read(8'h01, rdata);
		if (rdata != 8'h00)begin
			$display("%0t: [TSR test] TSR reset error", $time);
			error_cnt++;
		end
		check_int0();
		
		write(8'h02,8'hFF);
		write(8'h00,8'h04);
		write(8'h00,8'h03);
		repeat(248) @(posedge dut_vif.ker_clk);
		read(8'h01,rdata);
		if (rdata != 8'h00)begin
			$display("%0t: [TSR test] TSR rise soon", $time);
			error_cnt++;
		end
		check_int0();

		read(8'h01,rdata);
		if (rdata != 8'h02)begin
			$display("%0t: [TSR test] TSR is not set", $time);
			error_cnt++;
		end
		check_int1();
		
		write(8'h01, 8'h03);
		read(8'h01, rdata);
		if (rdata != 8'h00)begin
			$display("%0t: [TSR test] TSR reset error", $time);
			error_cnt++;
		end
		check_int0();
		
	endtask
endclass
