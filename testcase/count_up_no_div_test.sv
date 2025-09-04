class count_up_no_div_test extends base_test;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		wait(dut_vif.presetn == 1'b1);

		write(8'h03,8'h01);
		write(8'h00,8'h01);
		fork
			begin
				@(posedge dut_vif.interrupt);
				read(8'h01,rdata);
				if(rdata != 1)begin
				       	$display("%0t: [count up no div] TSR is not set",$time);
					error_cnt++;
					disable fork;
				end
				write(8'h01,8'h03);
				read(8'h01,rdata);
				if(rdata != 0)begin
				       	$display("%0t: [count up no div] TSR is not reset",$time);
					error_cnt++;
					disable fork;
				end
				if(dut_vif.interrupt != 0)begin
					error_cnt++;       
					$display("%0t: [count up no div] Interrupt is not reset",$time);
					disable fork;
				end
			end
			begin
				@(posedge dut_vif.interrupt);
				t1=$time;
				$display("%0t: [count up no div] Capture first interrupt time",$time);
				@(posedge dut_vif.interrupt);
				t2=$time;
				$display("%0t: [count up no div] Capture first interrupt time",$time);
				read(8'h01,rdata);
				if(rdata != 1)begin
				       	$display("%0t: [count up no div] TSR is not set",$time);
					error_cnt++;
					disable fork;
				end
				if((t2-t1)/5000 != 256)begin
					$display("%0t: [count up no div] Div clk error",$time);
					error_cnt++;
				end
			end
		join
	endtask
endclass
