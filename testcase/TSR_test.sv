class TSR_test  extends base_test;
	function new();
		super.new();
	endfunction
	function void check_int();
		if(dut_vif.interrupt != 0)begin
			$display("interrupt trigger");
			error_cnt++;
		end
	endfunction
	virtual task run_scenario();
	bit[7:0] rand_data;
		wait(dut_vif.presetn == 1'b1);
		//up
		write(8'h01, 8'h03);
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
		check_int();
		
		read(8'h01,rdata);
		if (rdata != 8'h01)begin
			$display("%0t: [TSR test] TSR is not set", $time);
			error_cnt++;
		end
		check_int();

		//down
		write(8'h00,8'h00);
		write(8'h02,8'hFF);
		write(8'h00,8'h04);
		write(8'h00,8'h03);
		repeat(248) @(posedge dut_vif.ker_clk);
		read(8'h01,rdata);
		if (rdata != 8'h01)begin
			$display("%0t: [TSR test] TSR rise soon", $time);
			error_cnt++;
		end
		check_int();

		read(8'h01,rdata);
		if (rdata != 8'h03)begin
			$display("%0t: [TSR test] TSR is not set", $time);
			error_cnt++;
		end
		check_int();
		
		write(8'h01, 8'h00);
		read(8'h01, rdata);
		if (rdata != 8'h03)begin
			$display("%0t: [TSR test] TSR error after write 0", $time);
			error_cnt++;
		end

		write(8'h01, 8'h03);
		read(8'h01, rdata);
		if (rdata != 8'h00)begin
			$display("%0t: [TSR test] TSR reset error", $time);
			error_cnt++;
		end
		
	endtask
endclass
