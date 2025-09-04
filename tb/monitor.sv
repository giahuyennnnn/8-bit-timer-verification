class monitor;
	packet pkt;
	mailbox #(packet) m2s_mb;
	virtual dut_if dut_vif;

	function new (virtual dut_if dut_vif, mailbox #(packet) m2s_mb);
		this.dut_vif = dut_vif;
		this.m2s_mb = m2s_mb;
	endfunction
	
	task run();
		forever begin
		@(posedge dut_vif.psel);
		pkt = new();
		$display("%0t: [Monitor] Start capturing APB transaction",$time);
		pkt.addr = dut_vif.paddr;
		if(dut_vif.pwrite == 1'b1)begin
			@(posedge dut_vif.penable);
			pkt.data = dut_vif.pwdata;
			pkt.transfer = packet::WRITE;
		end	
		else if(dut_vif.pwrite == 1'b0)begin
			@(posedge dut_vif.penable);
			pkt.data = dut_vif.prdata;
			pkt.transfer = packet::READ;
		end	
		m2s_mb.put(pkt);
		end
	endtask
endclass 
