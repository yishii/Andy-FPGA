
module PWM8_avalon_busif(
	input clk,
	input reset_n,
	input [1:0] address,
	input write,
	input [7:0] writedata,
	output [7:0] value1,
	output [7:0] value2,
	output pwmout1,
	output pwmout2);
	
	wire [7:0] value1_in;
	wire [7:0] value2_in;

	wire write_posedge;
	wire write_1d;

	// generate write posedge

	DFF_1 DFF_1_write_1dgen(
		.clk(clk),
		.n_rst(reset_n),
		.d(write),
		.q(write_1d));
	assign write_posedge = ((write == 1'b1) && (write_1d == 1'b0)) ? 1'b1 : 1'b0;
	
	// latch value1
	
	DFF_8 DFF_8_value1(
		.clk(clk),
		.n_rst(reset_n),
		.d(value1_in),
		.q(value1));
	assign value1_in = ((write_posedge == 1'b1) && (address == 2'b00)) ? writedata : value1;

	DFF_8 DFF_8_value2(
		.clk(clk),
		.n_rst(reset_n),
		.d(value2_in),
		.q(value2));
	assign value2_in = ((write_posedge == 1'b1) && (address == 2'b01)) ? writedata : value2;

	// associate value with PWM_8
	
	PWM8 pwm8_1(
		.clk(clk),
		.n_rst(reset_n),
		.value(value1),
		.pwmout(pwmout1));
	
	PWM8 pwm8_2(
		.clk(clk),
		.n_rst(reset_n),
		.value(value2),
		.pwmout(pwmout2));
	
endmodule
