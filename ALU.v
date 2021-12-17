`ifndef ALU_H
`define ALU_H

module ALU (
	input wire [15:0] x,
	input wire [15:0] y,
	input wire zx,
	input wire nx,
	input wire zy,
	input wire ny,
	input wire f,
	input wire no,
	output wire [15:0] out,
	output wire zr,
	output wire ng
);

	function [15:0] xy_m (
		input [15:0] xy,
		input zxy,
		input nxy
	);
		if (zxy == 1) begin
			if (nxy == 1) xy_m = ~(16'd0);
			else xy_m = 16'd0;
		end else begin
			if (nxy == 1) xy_m = ~xy;
			else xy_m = xy;
		end
	endfunction
	
	function [15:0] out_m (
		input [15:0] x_m,
		input [15:0] y_m,
		input f,
		input no
	);
		if (f == 1) 
			if (no == 1) out_m = ~(x_m + y_m);
			else out_m = (x_m + y_m);
		else
			if (no == 1) out_m = ~(x_m & y_m);
			else out_m = (x_m & y_m);
	endfunction
	
	wire [15:0] x_m = xy_m(x, zx, nx);
	wire [15:0] y_m = xy_m(y, zy, ny);
	
	assign out = out_m(x_m, y_m, f, no);
	assign zr = (out == 16'd0) ? 1'b1 : 1'b0;
	assign ng = out[15];
endmodule

`endif