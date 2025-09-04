class environment;
	stimulus sti;
	driver drv;
	monitor mon;
	scoreboard sb;

	mailbox #(packet) s2d_mb;
	mailbox #(packet) m2s_mb;

	virtual dut_if dut_vif;

	function new(virtual dut_if dut_vif);
		this.dut_vif = dut_vif;
	endfunction

	function void build();
		$display("%0t: [Environment] Build",$time);

		s2d_mb = new();
		m2s_mb = new();

		sti = new(s2d_mb);
		drv = new(dut_vif, s2d_mb);
		mon = new(dut_vif, m2s_mb);
		sb = new(m2s_mb);
	endfunction

	task run();
		fork
			sti.run();
			drv.run();
			mon.run();
			sb.run();
		join
	endtask
endclass


