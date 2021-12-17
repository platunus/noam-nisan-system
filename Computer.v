`timescale 1ps / 1ps
`include "CPU.v"
`include "ROM32K.v"
`include "Peripherals.v"

module Computer (
	input wire clk,	// 50MHz
	input wire rst_n,

	// Serial ROM for ROM implemenation
	output wire srom_cs_n,
	output wire srom_sck,
	output wire srom_di,		// input to Serial ROM
	input  wire srom_do, 	// output from Serial ROM
	
	// SRAM for ROM implementation
	output wire [14:0] sram_address,
	inout  wire [15:0] sram_dio,
	output wire sram_ce_n,
	output wire sram_oe_n,
	output wire sram_we_n,
	
	output wire clk_c,
//	output wire clk_r,
//	output wire clk_w,

	// Keyboard
	input wire key_sck,
	input wire key_mosi,
	input wire key_cs_n,
	output wire [7:0] key,
	
	// Screen
	output wire vga_hsync,
	output wire vga_vsync,
	output wire vga_r,
	output wire vga_g,
	output wire vga_b
);

	// Clock
	wire clk_cpu;
	wire clk_ram;
	wire clk_wren;
	wire clk_srom;	// 25MHz
	wire clk_vga;	// 25MHz

	// Memory (for CPU)
	wire [14:0] addressM;
	wire [15:0] inM;
	wire writeM;
	wire [15:0] outM;
	wire [14:0] pc;

	// ROM
	wire [15:0] instruction;	
	wire ready;
	
	// RAM
	reg loadM;
	
	// VGA
	wire vga_rgb;
	
	PLL PLL_inst (
		.clk(clk),
		.clk_cpu(clk_cpu),
		.clk_ram(clk_ram),
		.clk_wren(clk_wren),
		.clk_srom(clk_srom),
		.clk_vga(clk_vga)
   );

	 CPU CPU_inst(
		.clk_cpu(clk_cpu & ready),
		.inM(inM),
		.instruction(instruction),
		.rst_n(rst_n),
		.outM(outM),
		.writeM(writeM),
		.addressM(addressM),
		.pc(pc)
	);
	
	ROM32K ROM32K_inst (
		.clk_srom(clk_srom),
		.rst_n(rst_n),
		.ready(ready),
		.address(pc),
		.data(instruction),
		.srom_cs_n(srom_cs_n),
		.srom_sck(srom_sck),
		.srom_di(srom_di),		// input to Serial ROM
		.srom_do(srom_do), 		// output from Serial ROM
		.sram_address(sram_address),
		.sram_dio(sram_dio),
		.sram_ce_n(sram_ce_n),
		.sram_oe_n(sram_oe_n),
		.sram_we_n(sram_we_n)
	);
	
	Peripherals Peripherals_inst(
		.clk_cpu(clk_cpu & ready),
		.clk_ram(clk_ram & ready),
		.clk_vga(clk_vga),
		.rst_n(rst_n),
		.mem_address(addressM),
		.mem_out(inM),
		.mem_load(loadM),
		.mem_in(outM),
		.key_sck(key_sck),
		.key_mosi(key_mosi),
		.key_cs_n(key_cs_n),
		.key(key),
		.vga_hsync(vga_hsync),
		.vga_vsync(vga_vsync),
		.vga_rgb(vga_rgb)
	);
	
	assign clk_c = clk_cpu & ready;
//	assign clk_r = clk_ram & ready;
//	assign clk_w = loadM;
	
	assign vga_r = vga_rgb;
	assign vga_g = vga_rgb;
	assign vga_b = vga_rgb;
	
	// loadM is shifted of 90 degree for CPU clock
	always @(negedge clk_ram or negedge rst_n) begin
		if (rst_n == 1'b0) loadM <= 15'd0;
		else if (ready & !clk_cpu) loadM <= writeM;
		else loadM <= 15'd0;
	end
			
endmodule
