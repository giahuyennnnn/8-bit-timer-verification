class reserved_test extends base_test;
	function new();
		super.new();
	endfunction

	function void check(bit[7:0] addr, bit[7:0] data);
		if (data!=0) begin
			$display("%0t: [Reserved test]  Value of 8'h%h is not zero",$time,addr);
			error_cnt++;
		end
	endfunction
	virtual task run_scenario();
	bit[7:0] rand_data;
	bit[7:0] rand_addr;
		wait(dut_vif.presetn == 1'b1);
		for(int i = 1; i <= 100; i++) begin
			rand_data=$random;
			rand_addr=$urandom_range(4,255);
			@(posedge dut_vif.pclk);
			write(rand_addr,rand_data);
			read(rand_addr,rand_data);
			check(rand_addr,rand_data);
		end
	endtask
endclass
