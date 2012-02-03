module Nios2_MemoryMapLib_top(
	input CLK,
	input RST,
	output [9:0] LEDG,
	input [8:0] sw,
	output [7:0] nHEX0,nHEX1,nHEX2,nHEX3,
	input [2:0] nBUTTON,

	// SDRAM Interface
	output [11:0] DRAM_ADDR,
	output [ 1:0] DRAM_BA,
	output        DRAM_CAS_N,
	output        DRAM_CKE,
	output        DRAM_CS_N,
	inout  [15:0] DRAM_DQ,
	output [ 1:0] DRAM_DQM,
	output        DRAM_RAS_N,
	output        DRAM_WE_N,
	output        DRAM_CLK,
	inout  [31:0] GPIO1_D
	);

	wire n_reset;
	wire [7:0] pwmvalue1;
	wire [7:0] pwmvalue2;
	wire uart_txd;
	wire pwm_1;
	wire pwm_2;
	
	wire [3:0] gpio;
	
	assign n_reset = ~RST;
	assign DRAM_CLK = CLK;
	
	assign LEDG[4] = pwm_1;
	assign LEDG[5] = pwm_2;
	assign GPIO1_D[31] = pwm_1;
	assign GPIO1_D[29] = pwm_2;
	assign LEDG[3:0] = gpio[3:0];

	assign GPIO1_D[24] = gpio[1];
	assign GPIO1_D[26] = gpio[0];
	assign GPIO1_D[28] = gpio[3];
	assign GPIO1_D[30] = gpio[2];

  Nios2MemoryMapSDRAM Nios2MemoryMapSDRAM_inst
    (
      .clk_0                         (CLK),
      .out_port_from_the_pio_0       (gpio[3:0]),
      .pwmout1_from_the_pwm_avalon_0 (pwm_1),
      .pwmout2_from_the_pwm_avalon_0 (pwm_2),
      .reset_n                       (n_reset),
      .rxd_to_the_uart_0             (GPIO1_D[25]),
      .txd_from_the_uart_0           (GPIO1_D[27]),
      .value1_from_the_pwm_avalon_0  (pwmvalue1),
      .value2_from_the_pwm_avalon_0  (pwmvalue2),

      .zs_addr_from_the_sdram_0      (DRAM_ADDR[11:0]),
      .zs_ba_from_the_sdram_0        (DRAM_BA[1:0]),
      .zs_cas_n_from_the_sdram_0     (DRAM_CAS_N),
      .zs_cke_from_the_sdram_0       (DRAM_CKE),
      .zs_cs_n_from_the_sdram_0      (DRAM_CS_N),
      .zs_dq_to_and_from_the_sdram_0 (DRAM_DQ[15:0]),
      .zs_dqm_from_the_sdram_0       (DRAM_DQM[1:0]),
      .zs_ras_n_from_the_sdram_0     (DRAM_RAS_N),
      .zs_we_n_from_the_sdram_0      (DRAM_WE_N)
    );

	//assign DRAM_ADDR[12] = 1'b0;
	 
	decode7seg disp_col_1000(
		.data(pwmvalue2[7:4]),
		.decoded7seg(nHEX3[6:0]));
		
	decode7seg disp_col_100(
		.data(pwmvalue2[3:0]),
		.decoded7seg(nHEX2[6:0]));

	decode7seg disp_col_10(
		.data(pwmvalue1[7:4]),
		.decoded7seg(nHEX1[6:0]));

	decode7seg disp_col_1(
		.data(pwmvalue1[3:0]),
		.decoded7seg(nHEX0[6:0]));

	assign nHEX0[7] = nBUTTON[0];
	assign nHEX1[7] = 1'b1;
	assign nHEX2[7] = uart_txd;
	assign nHEX3[7] = uart_txd;
	
	assign LEDG[9] = uart_txd;
	
endmodule
