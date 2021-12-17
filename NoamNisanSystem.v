`timescale 1ps / 1ps
`include "Peripherals.v"

module NoamNisanSystem (
	input wire clk,
	input wire rst_n,
	
	// Keyboard
	input wire key_sck,
	input wire key_mosi,
	input wire key_cs_n,
	
	// Screen
	output wire vga_hsync,
	output wire vga_vsync,
	output wire vga_r,
	output wire vga_g,
	output wire vga_b,
	
	output wire [15:0] inst
);

	// Clock
	wire clk_cpu;	// 50MHz
	wire clk_mem;	// 50MHz
	reg clk_vga;	// 25MHz

	// Memory
	reg [14:0] mem_address;
	wire [15:0] mem_out;
	reg mem_load;
	reg [15:0] mem_in;

	// ROM
	reg [11:0] pc;
	wire [15:0] instruction;
	
	wire vga_rgb;
	
	ROM4K	ROM4K_inst(
		.address(pc),
		.clock(~clk_cpu),
		.q(instruction)
	);

	Peripherals Peripherals_inst(
		.clk_cpu(clk_cpu),
		.clk_vga(clk_vga),
		.rst_n(rst_n),
		.mem_address(mem_address),
		.mem_out(mem_out),
		.mem_load(mem_load),
		.mem_in(mem_in),
		.key_sck(key_sck),
		.key_mosi(key_mosi),
		.key_cs_n(key_cs_n),
		.vga_hsync(vga_hsync),
		.vga_vsync(vga_vsync),
		.vga_rgb(vga_rgb)
	);
	
	assign clk_cpu = clk;
	assign vga_r = vga_rgb;
	assign vga_g = vga_rgb;
	assign vga_b = vga_rgb;
	assign inst = instruction;
	
	initial begin
		pc = 12'd0;
		clk_vga = 1;
		mem_address = 15'd0;
		mem_load = 0;
		mem_in = 16'd0;
	end

	always @(negedge clk) begin
		clk_vga <= ~clk_vga;
	end
	
	always @(posedge clk_cpu) begin
		pc <= pc + 12'd1;
	end
		
	reg [14:0] address;
	reg phase;
	initial begin
		address = 15'd16384;
		phase = 0;
	end
	
	always @(posedge clk_cpu) begin
		phase <= ~phase;
		if (phase == 0) begin
			mem_address <= 15'd24576;
			mem_load <= 0;
			mem_in <= 16'd0;
		end else begin
			if (mem_out != 16'd0) begin
				if (address == 15'd24575) address <= 15'd16384;
				else address <= address + 15'd1;
				mem_address <= address;
				mem_load <= 1;
				mem_in <= mem_out;
			end
		end
	end
	
endmodule
