class base_test;
	environment env;
	virtual dut_if dut_vif;
	bit [7:0] data;
	bit [7:0] rdata;
	int error_cnt = 0;
	int t1,t2,t3,t4;
	int flag=0;

	function new();
	endfunction

	function void build();
		env = new(dut_vif);
		env.build();
	endfunction

	virtual task run_scenario();
	endtask

	task write(bit [7:0] addr, bit [7:0] data);
		packet pkt = new();
		pkt.addr = addr;
		pkt.data = data;
		pkt.transfer = packet::WRITE;
		env.sti.send_pkt(pkt);
		@(env.drv.xfer_done);
	endtask

	task read(bit [7:0] addr, ref bit [7:0] data);
		packet pkt = new();
		pkt.addr = addr;
		pkt.transfer = packet::READ;
		env.sti.send_pkt(pkt);
		@(env.drv.xfer_done);
		data = pkt.data;
	endtask

	task run_test();
		build();
		fork
			env.run();
			run_scenario();
		join_any
		env.sb.report(error_cnt);
		#1us;
		$display("%0t: [Base test] End simulation", $time);
		$finish;
	endtask
endclass



