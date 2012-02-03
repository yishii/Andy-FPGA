// pwm_avalon_0.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.

`timescale 1 ps / 1 ps
module pwm_avalon_0 (
		input  wire [1:0] address,   //   avalon_slave_0.address
		input  wire       write,     //                 .write
		input  wire [7:0] writedata, //                 .writedata
		input  wire       clk,       //       clock_sink.clk
		input  wire       reset_n,   // clock_sink_reset.reset_n
		output wire [7:0] value1,    //      conduit_end.export
		output wire [7:0] value2,    //                 .export
		output wire       pwmout1,   //                 .export
		output wire       pwmout2    //                 .export
	);

	PWM8_avalon_busif pwm_avalon_0 (
		.address   (address),   //   avalon_slave_0.address
		.write     (write),     //                 .write
		.writedata (writedata), //                 .writedata
		.clk       (clk),       //       clock_sink.clk
		.reset_n   (reset_n),   // clock_sink_reset.reset_n
		.value1    (value1),    //      conduit_end.export
		.value2    (value2),    //                 .export
		.pwmout1   (pwmout1),   //                 .export
		.pwmout2   (pwmout2)    //                 .export
	);

endmodule
