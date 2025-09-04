class default_value_register_test extends base_test;
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
		wait(dut_vif.presetn == 1'b1);
		for(bit [7:0] i = 0; i < 4; i++) begin
			@(posedge dut_vif.pclk);
			$display("%0t: Read value register",$time);
			read(i,rdata);
			check(i,rdata);
		end
	endtask
endclass



