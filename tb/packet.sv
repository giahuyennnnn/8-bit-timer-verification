class packet;
typedef enum bit {READ = 0, WRITE = 1} transfer_enum;
bit [7:0] addr;
bit [7:0] data;
transfer_enum transfer;
rand bit [7:0] TCR_data;
rand bit [7:0] TSR_data;
rand bit [7:0] TDR_data;
rand bit [7:0] TIE_data;
	function new ();

	endfunction
endclass 
