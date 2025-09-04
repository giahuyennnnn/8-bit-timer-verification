class count_down_load_div_4_test extends base_test;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		packet rand_data = new();

		wait(dut_vif.presetn == 1'b1);
		
		assert(rand_data.randomize()) else $error("%0t: [Count down load div 4] Randomization Failed",$time);
		write(8'h03,8'h02);
		write(8'h02,rand_data.TDR_data);
		write(8'h00,8'h04);
		write(8'h00,8'h13);
		fork
			begin
				@(posedge dut_vif.interrupt);
				read(8'h01,rdata);
				if(rdata != 2)begin
				       	$display("%0t: [Count down load div 4] TSR is not set",$time);
					error_cnt++;
					disable fork;
				end
				write(8'h01,8'h03);
				read(8'h01,rdata);
				if(rdata != 0)begin
				       	$display("%0t: [Count down load div 4] TSR is not reset",$time);
					error_cnt++;
					disable fork;
				end
				if(dut_vif.interrupt != 0)begin
					error_cnt++;       
					$display("%0t: [Count down load div 4] Interrupt is not reset",$time);
					disable fork;
				end
			end
			begin
				@(posedge dut_vif.interrupt);
				t1=$time;
				$display("%0t: [Count down load div 4] Capture first interrupt time",$time);
				@(posedge dut_vif.interrupt);
				t2=$time;
				$display("%0t: [Count down load div 4] Capture first interrupt time",$time);
				read(8'h01,rdata);
				if(rdata != 2)begin
				       	$display("%0t: [Count down load div 4] TSR is not set",$time);
					error_cnt++;
					disable fork;
				end
				if((t2-t1)/5000 != 1024)begin
					$display("%0t: [Count down load div 4] Div clk error",$time);
					error_cnt++;
				end
			end
		join
	endtask
endclass
