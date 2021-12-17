`timescale 1 ps/ 1 ps
module Peripherals_tb();
	// for input
	reg clk_cpu;	// 50MHz
	reg clk_vga;	// 25MHz
	reg rst_n;
	
	reg [14:0] mem_address;
	reg [15:0] mem_in;
	reg mem_load;
	
	reg key_sck;
	reg key_mosi;
	reg key_cs_n;
	
	// for output
	wire [15:0] mem_out;
	wire vga_hsync;
	wire vga_vsync;
	wire vga_rgb;

	Peripherals Peripherals_inst (
		.clk_cpu(clk_cpu),	// 50MHz
		.clk_vga(clk_vga),	// 25MHz
		.rst_n(rst_n),
		.mem_address(mem_address),
		.mem_in(mem_in),
		.mem_load(mem_load),
		.key_sck(key_sck),
		.key_mosi(key_mosi),
		.key_cs_n(key_cs_n),
		.mem_out(mem_out),
		.vga_hsync(vga_hsync),
		.vga_vsync(vga_vsync),
		.vga_rgb(vga_rgb)
	);
	initial begin
		clk_cpu = 0;
		clk_vga = 0;
		rst_n = 1;
		mem_address = 15'd0;
		mem_in = 16'd0;
		mem_load = 1;
		key_sck = 0;
		key_mosi = 0;
		key_cs_n = 1;
		#100 key_cs_n = 0;
		#100 key_mosi = 1;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_sck = ~key_sck;
		#100 key_mosi = 0;
		#100 key_cs_n = 1;
	end
	
	always #4 begin
		clk_cpu = ~clk_cpu;
	end

	always #8 begin
		clk_vga = ~clk_vga;
	end

	always @(posedge clk_cpu) begin
		mem_address = mem_address + 15'd1024;
		mem_load = ~mem_load;
		mem_in = mem_out + 16'd256;
	end

endmodule