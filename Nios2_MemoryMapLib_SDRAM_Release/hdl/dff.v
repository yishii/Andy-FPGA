//
// dff module
//
// Author : Yasuhiro ISHII
//

module DFF_1(
	input n_rst,
	input clk,
	input d,
	output reg q
);
	
	always @(posedge clk or negedge n_rst) begin
		if(~n_rst) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
	end

endmodule

module DFF_8(
	n_rst,
	clk,
	d,
	q
);
	input n_rst;
	input clk;
	input [7:0] d;
	output [7:0] q;
	reg [7:0] q;
	
	always @(posedge clk or negedge n_rst) begin
		if(~n_rst) begin
			q <= 8'h00;
		end else begin
			q <= d;
		end
	end

endmodule

