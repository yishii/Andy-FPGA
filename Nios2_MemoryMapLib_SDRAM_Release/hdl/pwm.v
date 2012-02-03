//
// PWM Generator
//
// Author : Yasuhiro ISHII
//

module PWM8(
	input clk,
	input n_rst,
	input [7:0] value,
	output pwmout);

	wire [7:0] counter;
	wire [7:0] counter_d;
	wire [7:0] divider;
	wire [7:0] divider_d;
	
	DFF_8 DFF_8_dividerGen(
		.n_rst(n_rst),
		.clk(clk),
		.d(divider_d),
		.q(divider));

	DFF_8 DFF_8_counterGen(
		.n_rst(n_rst),
		.clk(divider[3]),
		.d(counter_d),
		.q(counter));

	assign divider_d = (n_rst == 1'b0) ? 8'h00 : divider + 8'h01;	
	assign counter_d = (n_rst == 1'b0) ? 8'h00 : counter + 8'h01;
	assign pwmout = (n_rst == 1'b0) ? (1'b0) : ((counter <= value) ? (1'b1) : (1'b0));
	
endmodule
