`timescale 1 ps/ 1 ps
module Keyboard_tb();
	// for input
	reg rst_n;
	reg sck;
	reg mosi;
	reg cs_n;
	
	// for output
	wire [7:0] key;

	Keyboard Keyboard_inst(
		.rst_n(rst_n),
		.sck(sck),
		.mosi(mosi),
		.cs_n(cs_n),
		.key(key)
	);
	
	initial begin
		rst_n = 1;
		sck = 0;
		mosi = 0;
		cs_n = 1;
		#50 cs_n = 0;
		#50 mosi = 1;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 mosi = 0;
		#50 cs_n = 1;
		#200 cs_n = 0;
		#50 mosi = 1;
		#50 sck = ~sck;
		#50 sck = ~sck;
		mosi = ~mosi;
		#50 sck = ~sck;
		#50 sck = ~sck;
		mosi = ~mosi;
		#50 sck = ~sck;
		#50 sck = ~sck;
		mosi = ~mosi;
		#50 sck = ~sck;
		#50 sck = ~sck;
		mosi = ~mosi;
		#50 sck = ~sck;
		#50 sck = ~sck;
		mosi = ~mosi;
		#50 sck = ~sck;
		#50 sck = ~sck;
		mosi = ~mosi;
		#50 sck = ~sck;
		#50 sck = ~sck;
		mosi = ~mosi;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 mosi = 0;
		#50 cs_n = 1;
		#500 cs_n = 0;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 sck = ~sck;
		#50 cs_n = 1;
	end
endmodule
