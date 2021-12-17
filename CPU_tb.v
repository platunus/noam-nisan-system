`timescale 1 ps/ 1 ps
module CPU_tb();
	reg clk_cpu;
	reg [15:0] inM;
	reg [15:0] instruction;
	reg rst_n;
	wire [15:0] outM;
	wire writeM;
	wire [14:0] addressM;
	wire [14:0] pc;
	
	CPU CPU_inst(
		.clk_cpu(clk_cpu),
		.inM(inM),
		.instruction(instruction),
		.rst_n(rst_n),
		.outM(outM),
		.writeM(writeM),
		.addressM(addressM),
		.pc(pc)
	);
	
	initial begin
		clk_cpu = 0;
		rst_n = 0;
		inM = 16'd0;
		instruction = 16'd0;
		
		#20 rst_n = 1;
		inM         = 16'd0;
		instruction = 16'b0011000000111001;
// 2
		#10 inM     = 16'd0;
		instruction = 16'b1110110000010000;
// 3
		#10 inM     = 16'd0;
		instruction = 16'b0101101110100000;
// 4
		#10 inM     = 16'd0;
		instruction = 16'b1110000111010000;
// 5
		#10 inM     = 16'd0;
		instruction = 16'b0000001111101000;
// 6
		#10 inM     = 16'd0;
		instruction = 16'b1110001100001000;
// 7
		#10 inM     = 16'd0;
		instruction = 16'b0000001111101001;
// 8
		#10 inM     = 16'd0;
		instruction = 16'b1110001110011000;
// 9
		#10 inM     = 16'd0;
		instruction = 16'b0000001111101000;
// 10
		#10 inM     = 16'd11111;
		instruction = 16'b1111010011010000;
// 11
		#10 inM     = 16'd11111;
		instruction = 16'b0000000000001110;
// 12
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000100;
// 13
		#10 inM     = 16'd11111;
		instruction = 16'b0000001111100111;
// 14
		#10 inM     = 16'd11111;
		instruction = 16'b1110110111100000;
// 15
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100001000;
// 16
		#10 inM     = 16'd11111;
		instruction = 16'b0000000000010101;
// 17
		#10 inM     = 16'd11111;
		instruction = 16'b1110011111000010;
// 18
		#10 inM     = 16'd11111;
		instruction = 16'b0000000000000010;
// 19
		#10 inM     = 16'd11111;
		instruction = 16'b1110000010010000;
// 20
		#10 inM     = 16'd11111;
		instruction = 16'b0000001111101000;
// 21
		#10 inM     = 16'd11111;
		instruction = 16'b1110111010010000;
// 22
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000001;
// 23
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000010;
// 24
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000011;
// 25
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000100;
// 26
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000101;
// 27
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000110;
// 28
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000111;
// 29
		#10 inM     = 16'd11111;
		instruction = 16'b1110101010010000;
// 30
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000001;
// 31
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000010;
// 32
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000011;
// 33
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000100;
// 34
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000101;
// 35
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000110;
// 36
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000111;
// 37
		#10 inM     = 16'd11111;
		instruction = 16'b1110111111010000;
// 38
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000001;
// 39
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000010;
// 40
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000011;
// 41
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000100;
// 42
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000101;
// 43
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000110;
// 44
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000111;
// 45
		#10 inM     = 16'd11111;
		instruction = 16'b1110001100000111;
		rst_n       = 0;
// 46
		#10 inM     = 16'd11111;
		instruction = 16'b0111111111111111;
		rst_n       = 1;
		
	end
	
	always #5 begin
		clk_cpu = !clk_cpu;
	end
endmodule
