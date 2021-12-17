`timescale 1 ps/ 1 ps
module ALU_tb();
	reg [15:0] x;
	reg [15:0] y;
	reg zx;
	reg nx;
	reg zy;
	reg ny;
	reg f;
	reg no;
	wire [15:0] out;
	wire zr;
	wire ng;
	
	ALU ALU_inst(
		.x(x),
		.y(y),
		.zx(zx),
		.nx(nx),
		.zy(zy),
		.ny(ny),
		.f(f),
		.no(no),
		.out(out),
		.zr(zr),
		.ng(ng)
	);
	
	initial begin
		x = 16'h0000;
		y = 16'hffff;
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute 0
		#10
		zx = 1;
		nx = 0;
		zy = 1;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute 1
		#10
		zx = 1;
		nx = 1;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute -1
		#10
		zx = 1;
		nx = 1;
		zy = 1;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 0;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute !x
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 0;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute !y
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute -x
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute -y
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x + 1
		#10
		zx = 0;
		nx = 1;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y + 1
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x - 1
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y - 1
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x + y
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x - y 
		#10
		zx = 0;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y - x
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x & y
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x | y
		#10
		zx = 0;
		nx = 1;
		zy = 0;
		ny = 1;
		f  = 0;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
		#100
		x = 16'b000000000010001;	//17
		y = 16'b000000000000011;	// 3
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;

// Compute 0
		#10
		zx = 1;
		nx = 0;
		zy = 1;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute 1
		#10
		zx = 1;
		nx = 1;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute -1
		#10
		zx = 1;
		nx = 1;
		zy = 1;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 0;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute !x
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 0;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute !y
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute -x
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute -y
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x + 1
		#10
		zx = 0;
		nx = 1;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y + 1
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x - 1
		#10
		zx = 0;
		nx = 0;
		zy = 1;
		ny = 1;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y - 1
		#10
		zx = 1;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x + y
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x - y 
		#10
		zx = 0;
		nx = 1;
		zy = 0;
		ny = 0;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute y - x
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 1;
		f  = 1;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x & y
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
		
// Compute x | y
		#10
		zx = 0;
		nx = 1;
		zy = 0;
		ny = 1;
		f  = 0;
		no = 1;
		
		#10
		zx = 0;
		nx = 0;
		zy = 0;
		ny = 0;
		f  = 0;
		no = 0;
	end
endmodule
