`ifndef CPU_H
`define CPU_H

module CPU (
	input wire clk_cpu,
	input wire [15:0] inM,
	input wire [15:0] instruction,
	input wire rst_n,
	output wire [15:0] outM,
	output wire writeM,
	output wire [14:0] addressM,
	output reg [14:0] pc
);
	reg [14:0] A;
	reg [15:0] D;
	wire [14:0] inA;
	wire [15:0] AM;
	wire zr, ng;
	
	wire i = instruction[15];
	wire a = instruction[12];
	wire c1 = instruction[11];
	wire c2 = instruction[10];
	wire c3 = instruction[9];
	wire c4 = instruction[8];
	wire c5 = instruction[7];
	wire c6 = instruction[6];
	wire d1 = instruction[5];
	wire d2 = instruction[4];
	wire d3 = instruction[3];
	wire j1 = instruction[2];
	wire j2 = instruction[1];
	wire j3 = instruction[0];
	
	wire C0 = !i;
	wire C1 = C0 | d1;
	wire C2 = d2 & i;
	wire C4 = a;
	wire C5 = i &((!j1 & j3 & !zr & !ng ) | (!j1 & j2 & zr) | (j1 & !j3 & !zr & ng) |
					(j1 & !j2 & j3 & !zr) | (j1 & j2 & !j3 & zr) | (j1 & j2 & j3));
	wire C6 = !C5;
	wire C7 = d3 & i;
	
	ALU ALU_inst(
		.x(D),
		.y(AM),
		.zx(c1),
		.nx(c2),
		.zy(c3),
		.ny(c4),
		.f(c5),
		.no(c6),
		.out(outM),
		.zr(zr),
		.ng(ng)
	);
	
	assign writeM = C7;
	assign addressM = A;
	assign inA = (C0 == 0) ? outM[14:0] : instruction[14:0];
	assign AM = (C4 == 0) ? {1'b0, A} : inM;

	initial begin
		A = 15'd0;
		D = 16'd0;
		pc = 15'd0;
	end
	
	always @(posedge clk_cpu or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			A <= 15'd0;
			D <= 16'd0;
			pc <= 15'd0;
		end else begin
			if (C1 == 1) A <= inA;
			if (C2 == 1) D <= outM;
		
			if (C5 == 1) pc <= A;				// C5:load
			else if (C6 == 1) pc <= pc + 15'd1;	// C6:inc
		end
	end	
endmodule
	
`endif