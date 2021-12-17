`timescale 1 ps/ 1 ps
module NoamNisanSystem_tb();
	reg clk;
	reg rst_n;
	
	// Keyboard
	reg key_sck;
	reg key_mosi;
	reg key_cs_n;
	
	// Screen
	wire vga_hsync;
	wire vga_vsync;
	wire vga_r;
	wire vga_g;
	wire vga_b;
	
	wire [15:0] inst;

NoamNisanSystem NoamNisanSystem_inst (
	.clk(clk),
	.rst_n(rst_n),
	.key_sck(key_sck),
	.key_mosi(key_mosi),
	.key_cs_n(key_cs_n),
	.vga_hsync(vga_hsync),
	.vga_vsync(vga_vsync),
	.vga_r(vga_r),
	.vga_g(vga_g),
	.vga_b(vga_b)
);

	initial begin
		clk = 0;
		rst_n = 1;
		key_sck = 0;
		key_mosi = 0;
		key_cs_n = 1;
		#120 key_cs_n = 0;
		#120 key_mosi = 1;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_mosi = 0;
		#120 key_cs_n = 1;
		#300 key_cs_n = 0;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_sck = ~key_sck;
		#120 key_cs_n = 1;
	end
	
	always #10 begin
		clk = ~clk;
	end
		
endmodule