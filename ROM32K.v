`ifndef ROM32K_H
`define ROM32K_H

module ROM32K (
	input wire clk_srom,	// 50MHz
	input wire rst_n,
	output reg ready,
	
	input wire [14:0] address,
	output wire [15:0] data,

	// Serial ROM
	output reg srom_cs_n,
	output wire srom_sck,
	output reg srom_di,		// input to Serial ROM
	input  wire srom_do, 	// output from Serial ROM
	
	// SRAM
	output wire [14:0] sram_address,
	inout wire [15:0] sram_dio,
	output wire sram_ce_n,
	output reg sram_oe_n,
	output reg sram_we_n
);
		
	parameter STAGE_INIT          = 3'd0;
	parameter STAGE_INSTRUCTION   = 3'd1;
	parameter STAGE_ADDRESS_DUMMY = 3'd2;
	parameter STAGE_DATA          = 3'd3;
	parameter STAGE_TERM          = 3'd4;
	
	parameter INSTRUCTION_FAST_READ = 8'h0b;
	parameter SROM_WORD_MAX_ADDRESS = 15'h7fff;
	
	reg [2:0] stage;
	reg [5:0] count;
	reg [5:0] count_s;
	reg [14:0] sram_address_wr;
	reg [15:0] sram_di;
	reg [15:0] sram_di_tmp;

	wire srom_sck_en;	
	wire [7:0] srom_instruction = INSTRUCTION_FAST_READ;
	
	assign srom_sck_en = (stage == STAGE_INIT || stage == STAGE_TERM) ? 1'b0 : 1'b1;
	assign srom_sck = clk_srom & srom_sck_en;

	assign data = (ready) ? sram_dio : 16'd0;
	assign sram_address = (ready) ? address : sram_address_wr;
	assign sram_dio = (ready) ? 16'bz: sram_di;
	assign sram_ce_n = 1'b0;
	
		
	initial begin
		ready = 1'b0;
		srom_cs_n = 1'b1;
		srom_di = 1'b0;
		sram_we_n = 1'b1;
		sram_oe_n = 1'b0;
		stage = STAGE_INIT;
		count = 5'd0;
		count_s = 5'd0;
		sram_address_wr = SROM_WORD_MAX_ADDRESS;
		sram_di = 16'd0;
		sram_di_tmp = 16'd0;
	end
	
	// ready
	always @(posedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) ready <= 1'b0;
		else if (stage == STAGE_TERM && count_s == 5'd3) ready <= 1'b1;
	end
	
	// srom_cs_n
	always @(negedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) srom_cs_n = 1'b1;
		else if (!ready) begin
			if (stage == STAGE_INIT && count_s == 5'd0) srom_cs_n <= 1'b0;
			else if (stage == STAGE_TERM) srom_cs_n <= 1'b1;
		end
	end
	
	// srom_di
	always @(negedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) srom_di = 1'b0;
		else if (!ready) begin
			if (stage == STAGE_INSTRUCTION) begin
				srom_di <= srom_instruction[5'd6 - count_s];
			end else if (stage == STAGE_ADDRESS_DUMMY) begin
				srom_di <= 1'b0;
			end
		end
	end
	
	// stage, count
	always @(negedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			stage <= STAGE_INIT;
			count <= 5'd0;
		end else if (!ready) begin
			case (stage)
				STAGE_INIT: begin
					if (count == 5'd1) begin
						count <= 5'd0;
						stage <= STAGE_INSTRUCTION;
					end else	count <= count + 5'd1;
				end
				STAGE_INSTRUCTION: begin
					if (count == 5'd7) begin
						count <= 5'd0;
						stage <= STAGE_ADDRESS_DUMMY;
					end else count <= count + 5'd1;
				end
				STAGE_ADDRESS_DUMMY: begin
					if (count == 5'd31) begin
						count <= 5'd0;
						stage <= STAGE_DATA;
					end else count <= count + 5'd1;
				end
				STAGE_DATA: begin
					if (count == 5'd15) begin
						count <= 5'd0;
						if (sram_address_wr == SROM_WORD_MAX_ADDRESS) begin
							stage <= STAGE_TERM;
						end
					end else count <= count + 5'd1;
				end
				STAGE_TERM: begin
					count <= count + 5'd1;
				end
			endcase
		end
	end

	// count_s
	always @(posedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) count_s <= 5'd0;
		else count_s <= count;
	end
	
	// sram_oe_n
	always @(negedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) sram_oe_n <= 1'b1;
		else if (stage == STAGE_INIT) sram_oe_n <= 1'b1;
		else if (stage == STAGE_TERM) sram_oe_n <= 1'b0;
	end
	
	// sram_we_n
	always @(negedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) sram_we_n <= 1'b1;
		else if (stage == STAGE_DATA) begin
			if (count_s == 5'd7) sram_we_n = 1'b0;
			else if  (count_s == 5'd15) sram_we_n = 1'b1;
		end
	end
	
	// sram_di
	always @(posedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			sram_di <= 16'd0;
			sram_di_tmp <= 16'd0;
		end else if (stage == STAGE_DATA) begin
			if (count == 5'd15) sram_di <= {sram_di_tmp[14:0], srom_do};
//			if (count == 5'd15) sram_di <= {1'b0, sram_address_wr};
			sram_di_tmp <= {sram_di_tmp[14:0], srom_do};
		end
	end
	
	// sram_address_wr
	always @(posedge clk_srom or negedge rst_n) begin
		if (rst_n == 1'b0) sram_address_wr <= 15'h7fff;
		else if (stage == STAGE_DATA && count == 5'd0) 
			sram_address_wr <= sram_address_wr + 15'd1;
		else if (stage == STAGE_TERM && count == 5'd0) 
			sram_address_wr <= 15'd0;
	end
	
endmodule
	
`endif
