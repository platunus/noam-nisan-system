`timescale 1 ps/ 1 ps
module Screen_tb();
	// for input
	reg clk;
	reg rst_n;
	
	// for output
	wire [12:0] address_vram_vga;
	wire hsync;
	wire vsync;
	wire [15:0] data_vram_vga;
	wire rgb;
	
	// inner
	wire [15:0] data_vram_cpu;

	Screen Screen_inst (
		.clk(clk),
		.rst_n(rst_n),
		.data_vram(data_vram_vga),
		.address_vram(address_vram_vga),
		.hsync(hsync),
		.vsync(vsync),
		.rgb(rgb)
	);
	
	VRAM8K VRAM8K_inst (
		.address_a(13'd0),
		.address_b(address_vram_vga),
		.clock_a(clk),
		.clock_b(clk),
		.data_a(16'd0),
		.data_b(16'd0),
		.wren_a(1'b0),
		.wren_b(1'b0),
		.q_a(data_vram_cpu),
		.q_b(data_vram_vga)
	);

	initial begin
		clk = 0;
		rst_n = 1;
	end
	
	always #10 begin
		clk = ~clk;
	end
	
endmodule
