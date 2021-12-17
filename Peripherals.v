`timescale 1ps / 1ps
`ifndef PERIPHERALS_H
`define PERIPHERALS_H

`include "Screen.v"
`include "Keyboard.v"

module Peripherals (
	input wire clk_cpu,
	input wire clk_ram,
	input wire clk_vga,	// 25MHz
	input wire rst_n,
	
	// Memory
	input wire [14:0] mem_address,
	output wire [15:0] mem_out,
	input wire mem_load,
	input wire [15:0] mem_in,

	// Keyboard
	input wire key_sck,
	input wire key_mosi,
	input wire key_cs_n,
	output wire [7:0] key,
	
	// Screen
	output wire vga_hsync,
	output wire vga_vsync,
	output wire vga_rgb
);

	parameter ADDRESS_KEY = 24576;
	
	wire [13:0] address_ram;
	wire [12:0] address_vram;
	wire [12:0] address_vram_vga;
	
	wire [15:0] data_ram_rd;
	wire [15:0] data_vram_rd;
	wire [15:0] data_vram_vga;
	
	wire wren_ram;
	wire wren_vram;
	
//	wire [7:0] key;

	RAM16K RAM16K_inst (
		.address(address_ram),
		.clock(clk_ram),
		.data(mem_in),
		.wren(wren_ram),
		.q(data_ram_rd)
	);

	VRAM8K VRAM8K_inst (
		.address_a(address_vram),
		.address_b(address_vram_vga),
		.clock_a(clk_ram),
		.clock_b(~clk_vga),
		.data_a(mem_in),
		.data_b(16'd0),
		.wren_a(wren_vram),
		.wren_b(1'b0),
		.q_a(data_vram_rd),
		.q_b(data_vram_vga)
	);

	Keyboard Keyboard_inst(
		.rst_n(rst_n),
		.sck(key_sck),
		.mosi(key_mosi),
		.cs_n(key_cs_n),
		.key(key)
	);
	
	Screen Screen_inst (
		.clk(clk_vga),
		.rst_n(rst_n),
		.data_vram(data_vram_vga),
		.address_vram(address_vram_vga),
		.hsync(vga_hsync),
		.vsync(vga_vsync),
		.rgb(vga_rgb)
	);
	
	assign wren_ram = (mem_address[14] == 0) & mem_load;
	assign wren_vram = (mem_address[14:13] == 2'b10) & mem_load;

	assign address_ram = (mem_address[14] == 0) ? mem_address[13:0] : 14'd0;
	assign address_vram = (mem_address[14:13] == 2'b10) ? mem_address[12:0] : 13'd0;
	
	assign mem_out = get_out(mem_address, data_ram_rd, data_vram_rd, key);
	
	function [15:0] get_out(
		input [14:0] mem_address,
		input [15:0] data_ram_rd,
		input [15:0] data_vram_rd,
		input [7:0] key
	);
		if (mem_address[14] == 0) get_out = data_ram_rd;
		else if (mem_address[14:13] == 2'b10) get_out = data_vram_rd;
		else if (mem_address == ADDRESS_KEY) get_out = {8'd0, key};
		else get_out = 16'd0;
	endfunction
			
endmodule

`endif
