`ifndef SCREEN_H
`define SCREEN_H

module Screen (
	input wire clk,
	input wire rst_n,
	input wire [15:0] data_vram,
	output wire [12:0] address_vram,
	output reg hsync,
	output reg vsync,
	output wire rgb
);

	// horizontal constants
	parameter H_DISPLAY       = 640; // horizontal display width
	parameter H_BACK          =  48; // horizontal left border (back porch)
	parameter H_FRONT         =  16; // horizontal right border (front porch)
	parameter H_SYNC          =  96; // horizontal sync width
	parameter H_WINDOW_MIN    = 64; 
	parameter H_WINDOW_MAX    = 64 + 511; 
	// vertical constants
	parameter V_DISPLAY       = 480; // vertical display height
	parameter V_TOP           =  31; // vertical top border
	parameter V_BOTTOM        =  11; // vertical bottom border
	parameter V_SYNC          =   2; // vertical sync # lines
	parameter V_WINDOW_MIN    = 112; 
	parameter V_WINDOW_MAX    = 112 + 255; 
	// derived constants
	parameter H_SYNC_START    = H_DISPLAY + H_FRONT;
	parameter H_SYNC_END      = H_DISPLAY + H_FRONT + H_SYNC - 1;
	parameter H_MAX           = H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1;
	parameter V_SYNC_START    = V_DISPLAY + V_BOTTOM;
	parameter V_SYNC_END      = V_DISPLAY + V_BOTTOM + V_SYNC - 1;
	parameter V_MAX           = V_DISPLAY + V_TOP + V_BOTTOM + V_SYNC - 1;
  
	reg [9:0] hpos, vpos;
	reg [9:0] hpos_next, vpos_next;
	reg [15:0] data;

	initial begin
		hsync = 1'b0;
		vsync = 1'b0;
		hpos = 10'd0;
		vpos = 10'd0;
		hpos_next = 10'd0;
		vpos_next = 10'd0;
		data = 15'd0;
	end
  
	wire hmaxxed = (hpos_next == H_MAX) || !rst_n;  // set when hpos is maximum
	wire vmaxxed = (vpos_next == V_MAX) || !rst_n;  // set when vpos is maximum

	// horizontal position counter
	always @(posedge clk) begin
		hsync <= (hpos>=H_SYNC_START && hpos<=H_SYNC_END);
		if(hmaxxed) hpos_next <= 10'd0;
		else hpos_next <= hpos_next + 10'd1;
		hpos <= hpos_next;
	end

	// vertical position counter
	always @(posedge clk) begin
		vsync <= (vpos>=V_SYNC_START && vpos<=V_SYNC_END);
		if(hmaxxed) begin
			if (vmaxxed) vpos_next <= 10'd0;
			else vpos_next <= vpos_next + 10'd1;
		end
		vpos <= vpos_next;
	end
  
	always @(posedge clk) begin
		data <= data_vram;
	end
	
	assign rgb = (hpos>=H_WINDOW_MIN && hpos<=H_WINDOW_MAX && 
						vpos>=V_WINDOW_MIN && vpos<=V_WINDOW_MAX && 
						data[hpos[3:0]]);
						
	assign address_vram = {vpos_next[7:0] - 8'd112, 5'd0} 
									+ {8'd0, hpos_next[8:4] - 4'd4}; 

endmodule

`endif
