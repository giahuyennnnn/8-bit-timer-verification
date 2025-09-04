class scoreboard;
	packet pkt;
	mailbox #(packet) m2s_mb;
	int error_cnt = 0;

	function new (mailbox #(packet) m2s_mb);
		this.m2s_mb = m2s_mb;
	endfunction
	
	task run();
		pkt = new();
		forever begin
		m2s_mb.get(pkt);
		$display("%0t: [Scoreboard] Get packet from Monitor: %s, addr = 8'h%h, data = 8'h%h",$time,pkt.transfer.name(),pkt.addr,pkt.data);
		end
	endtask
	function void report(int error_cnt);
		int total_error = this.error_cnt + error_cnt;

		if (total_error == 0) begin
			$display("%0t: [Scoreboard] Status: TEST PASSED", $time);
		end
		else begin
			$display("%0t: [Scoreboard] Status: TEST FAILED", $time);
			$display("%0t: [Scoreboard] Test error: %0d", $time, total_error);
		end
	endfunction
endclass 
