class driver;
	mailbox #(packet) s2d_mb;
	virtual dut_if dut_vif;
	event xfer_done;

	function new (virtual dut_if dut_vif, mailbox #(packet) s2d_mb);
		this.dut_vif = dut_vif;
		this.s2d_mb = s2d_mb;
	endfunction
	
	task run();
		packet pkt;
		forever begin
			s2d_mb.get(pkt);
			$display("%0t: [Driver] Get packet from Stimulus",$time);
			
			$display("%0t: [Driver] Start APB transfer",$time);
			wait(dut_vif.presetn === 1);
			@(posedge dut_vif.pclk);
			dut_vif.psel = 1;
			dut_vif.penable = 0;
			dut_vif.paddr = pkt.addr;
			dut_vif.pwrite = (pkt.transfer == packet::WRITE) ? 1 : 0;
			dut_vif.pwdata = (pkt.transfer == packet::WRITE) ? pkt.data : 0;
		
			@(posedge dut_vif.pclk);
			dut_vif.penable = 1;
			pkt.data = (pkt.transfer == packet::READ) ? dut_vif.prdata : pkt.data;

			@(posedge dut_vif.pclk);
			dut_vif.psel = 0;
			dut_vif.penable = 0;
			dut_vif.paddr = 0;
			dut_vif.pwrite = 0;
			dut_vif.pwdata = 0;
			dut_vif.prdata = 0;
			
			-> xfer_done;
			
		end
	endtask
endclass 
