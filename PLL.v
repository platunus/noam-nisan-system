`ifndef PLL_H
`define PLL_H

module PLL (
	input  wire clk,				// 50MHz
	output wire clk_cpu,	   	// 12.5MHz (=50MHz/4)
	output wire clk_ram,
	output wire clk_wren,
	output wire clk_srom,	   // 25MHz (=50MHz/2)
	output wire clk_vga	      // 25MHz (=50MHz/2)
);

	reg [4:0] count;
	initial begin
		count = 5'd0;
	end
	
	always @(posedge clk) begin
		count <= count + 5'd1;
	end

	assign clk_cpu = count[3];
	assign clk_ram = !count[2];
	assign clk_wren = (count[2] ^ count[3]);
/*	
	assign clk_cpu = count[1];
	assign clk_ram = !count[0];
	assign clk_wren = (count[0] ^ count[1]);
*/
	assign clk_srom = count[0];
	assign clk_vga = count[0];

endmodule

`endif