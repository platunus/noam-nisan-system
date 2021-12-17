`ifndef KEYBOARD_H
`define KEYBOARD_H

module Keyboard (
	input wire rst_n,
	input wire sck,
	input wire mosi,
	input wire cs_n,
	output reg [7:0] key
);
	reg [7:0] key_pre;
	
	initial begin
		key = 8'd0;
		key_pre = 8'd0;
	end
	
	// key
	always @(posedge cs_n or negedge rst_n) begin
		if (rst_n == 1'b0) key <= 8'd0;
		else key <= key_pre;
	end
	
	// key_pre
	always @(posedge sck or negedge rst_n) begin
		if (rst_n == 1'b0) key_pre <= 8'd0;
		else key_pre <= {key_pre[6:0], mosi};
	end
	
endmodule

`endif