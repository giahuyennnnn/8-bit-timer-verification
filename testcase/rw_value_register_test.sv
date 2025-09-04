class rw_value_register_test extends base_test;
	packet rand_data;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	//TCR
		bit [7:0] check;
		int i;
		for(i = 0; i < 4; i++) begin
			wait(dut_vif.presetn == 1'b1);
			@(posedge dut_vif.pclk);
			case(i)
				0:begin check = 8'h00; write(8'h00,check);read(8'h00,rdata);end
				1:begin check = 8'h55; write(8'h00,check);read(8'h00,rdata);end
				2:begin check = 8'hAA; write(8'h00,check);read(8'h00,rdata);end
				3:begin check = 8'hFF; write(8'h00,check);read(8'h00,rdata);end
			endcase
			if(rdata[4:0] != check[4:0] && rdata[7:5] != 0)begin
				$display("%0t: [RW register test] Value of TCR is NOT matching or reserved bit error",$time);
				error_cnt++;
			end
		end
	//TDR
		for(i = 0; i < 4; i++) begin
			wait(dut_vif.presetn == 1'b1);
			@(posedge dut_vif.pclk);
			case(i)
				0:begin check = 8'h00; write(8'h02,check);read(8'h02,rdata);end
				1:begin check = 8'h55; write(8'h02,check);read(8'h02,rdata);end
				2:begin check = 8'hAA; write(8'h02,check);read(8'h02,rdata);end
				3:begin check = 8'hFF; write(8'h02,check);read(8'h02,rdata);end
			endcase
			if(rdata != check)begin
				$display("%0t: [RW register test] Value of TDR is NOT matching",$time);
				error_cnt++;
			end
		end
	//TIE
		for(i = 0; i < 4; i++) begin
			wait(dut_vif.presetn == 1'b1);
			@(posedge dut_vif.pclk);
			case(i)
				0:begin check = 8'h00; write(8'h03,check);read(8'h03,rdata);end
				1:begin check = 8'h55; write(8'h03,check);read(8'h03,rdata);end
				2:begin check = 8'hAA; write(8'h03,check);read(8'h03,rdata);end
				3:begin check = 8'hFF; write(8'h03,check);read(8'h03,rdata);end
			endcase
			if(rdata[1:0] != check[1:0] && rdata[7:2] != 0)begin
				$display("%0t: [RW register test] Value of TIE is NOT matching or reserved bit error",$time);
				error_cnt++;
			end
		end
	//Write all then Read all
		wait(dut_vif.presetn == 1'b1);
		rand_data = new();
		assert(rand_data.randomize()) else $error("Randomization Failed");
		write(8'h00,rand_data.TCR_data);
		write(8'h02,rand_data.TDR_data);
		write(8'h03,rand_data.TIE_data);
	//Read TCR
		read(8'h00,rdata);
		if(rdata[4:0] != rand_data.TCR_data[4:0] || rdata[7:5] != 0)begin
			$display("%0t: [RW register test] Value of TCR is NOT matching or reserved bit error",$time);
			error_cnt++;
		end
	//Read TDR
		read(8'h02,rdata);
		if(rdata != rand_data.TDR_data)begin
			$display("%0t: [RW register test] Value of TDR is NOT matching",$time);
			error_cnt++;
		end
	//Read TIE
		read(8'h03,rdata);
	if(rdata[1:0] != rand_data.TIE_data[1:0] || rdata[7:2] != 0)begin
			$display("%0t: [RW register test] Value of TIE is NOT matching or reserved bit error",$time);
			error_cnt++;
		end
	endtask

endclass
