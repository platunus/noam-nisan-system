`timescale 1 ps/ 1 ps
module ROM32K_tb();
	// for input
	reg clk_srom;	// 50MHz
	reg rst_n;
	reg [14:0] address;
	wire srom_do;
	reg [5:0] count;
	reg stage;
	reg [15:0] srom_data;

	// for output
	wire ready;
	wire [15:0] data;
	wire srom_cs_n;
	wire srom_sck;
	wire srom_di;
	wire [14:0] sram_address;
	wire sram_ce_n;
	wire sram_oe_n;
	wire sram_we_n;

	// for inout
	wire [15:0] sram_dio;
	
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

	initial begin
		clk_srom = 0;
		rst_n = 1;
		address = 15'd0;
		count = 6'd0;
		stage = 0;
		srom_data = 16'd1001;
	end
	
	always #4 begin
		clk_srom = ~clk_srom;
	end

	always @(negedge clk_srom) begin
		if (stage == 0) begin
			if (count == 6'd41) begin
				count <= 6'd0;
				stage <= 1;
			end else count <= count + 1;
		end else begin
			if (count == 6'd15) begin
				count <= 0;
				srom_data <= srom_data + 6'd1;
			end else count <= count + 1;
		end
	end
	
	assign srom_do = srom_data[15 - count];

endmodule