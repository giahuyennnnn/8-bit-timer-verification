class stimulus;
	packet pkt;
	mailbox #(packet) s2d_mb;
	packet pkt_q[$];

	function new (mailbox #(packet) s2d_mb);
		this.s2d_mb = s2d_mb;
	endfunction
	function void send_pkt (packet pkt_get);
		$display("%0t: [Stimulus] Get packet", $time);
		pkt_q.push_back(pkt_get);
	endfunction
	task run();
		pkt = new();
		forever begin
			wait(pkt_q.size() > 0);
			pkt = pkt_q.pop_front();
			s2d_mb.put(pkt);
			$display("%0t: [Stimulus] Send packet to Driver",$time);
		end
	endtask
endclass 
