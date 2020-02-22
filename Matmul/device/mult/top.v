/*============================================================================*/
/* Arrow Electronics														 						*/
/* Engineering and Design Services											 				*/
/* 																			 						*/
/* Arrow SoCkit Evaluation Board											 					*/
/* Altera OpenCL BSP																 				*/
/* v14.0																	 							*/
/* 																			 						*/
/*============================================================================*/
/* Copyright (c) 2014 by Arrow Electronics, Inc.										*/
/*============================================================================*/
/*                                                                            */
/* Permission:                                                                */
/*                                                                            */
/*   Arrow grants permission to use and modify this code for use              */
/*   in synthesis for all Arrow Development Boards. Other use of this code,   */
/*	  including the selling, duplication or modification of any portion is     */
/*   strictly prohibited.                                                     */
/*                                                                            */
/* Disclaimer:                                                                */
/*                                                                            */
/*   This VHDL/Verilog or C/C++ source code is intended as a design reference */
/*   which illustrates how these types of functions can be implemented.       */
/*   It is the user's responsibility to verify their design for               */
/*   consistency and functionality through the use of formal                  */
/*   verification methods.  Arrow provides no warranty regarding the use      */
/*   or functionality of this code.                                           */
/*                                                                            */
/*============================================================================*/

module top (
	input					fpga_clk_50,
  	input					fpga_reset_n,
  	output	[ 3:0]	fpga_led_output,
  
 	output	[14:0]	memory_mem_a,
  	output	[ 2:0]	memory_mem_ba,
  	output				memory_mem_ck,
  	output				memory_mem_ck_n,
  	output				memory_mem_cke,
  	output				memory_mem_cs_n,
  	output				memory_mem_ras_n,
  	output				memory_mem_cas_n,
  	output				memory_mem_we_n,
  	output				memory_mem_reset_n,
  	inout		[31:0]	memory_mem_dq,
  	inout		[ 3:0]	memory_mem_dqs,
  	inout		[ 3:0]	memory_mem_dqs_n,
  	output				memory_mem_odt,
  	output	[ 3:0]	memory_mem_dm,
  	input					memory_oct_rzqin,
  
  	inout					emac_mdio,
	output				emac_mdc,
	output				emac_tx_ctl,
	output				emac_tx_clk,
	output	[ 3:0]	emac_txd,
  	input					emac_rx_ctl,
	input					emac_rx_clk,
  	input		[ 3:0]	emac_rxd,

  	inout					sd_cmd,
  	output				sd_clk,
  	inout		[ 3:0]	sd_d,
  	input					uart_rx,
  	output				uart_tx,
  	inout		[ 3:0]	led
);



// wires for conduits
  wire        	fpga_sdram_status_local_init_done;
  wire        	fpga_sdram_status_local_cal_success;
  wire        	fpga_sdram_status_local_cal_fail;
  wire        	fpga_sdram_pll_sharing_pll_mem_clk;
  wire        	fpga_sdram_pll_sharing_pll_write_clk;
  wire        	fpga_sdram_pll_sharing_pll_write_clk_pre_phy_clk;
  wire        	fpga_sdram_pll_sharing_pll_addr_cmd_clk;
  wire        	fpga_sdram_pll_sharing_pll_locked;
  wire       	fpga_sdram_pll_sharing_pll_avl_clk;
  wire        	fpga_sdram_pll_sharing_pll_config_clk;
  wire        	fpga_sdram_pll_sharing_pll_mem_phy_clk;
  wire        	fpga_sdram_pll_sharing_afi_phy_clk;
  wire        	fpga_sdram_pll_sharing_pll_avl_phy_clk;

  wire	[29:0]	fpga_internal_led;
  wire				kernel_clk;

	system the_system (
		.reset_50_reset_n                    			(fpga_reset_n),
		.clk_50_clk                          			(fpga_clk_50),
    	.kernel_clk_clk										(kernel_clk),
		.memory_mem_a                        			(memory_mem_a),
		.memory_mem_ba                       			(memory_mem_ba),
		.memory_mem_ck                       			(memory_mem_ck),
		.memory_mem_ck_n                     			(memory_mem_ck_n),
		.memory_mem_cke                      			(memory_mem_cke),
		.memory_mem_cs_n                     			(memory_mem_cs_n),
		.memory_mem_ras_n                    			(memory_mem_ras_n),
		.memory_mem_cas_n                    			(memory_mem_cas_n),
		.memory_mem_we_n                     			(memory_mem_we_n),
		.memory_mem_reset_n                  			(memory_mem_reset_n),
		.memory_mem_dq                       			(memory_mem_dq),
		.memory_mem_dqs                      			(memory_mem_dqs),
		.memory_mem_dqs_n                    			(memory_mem_dqs_n),
		.memory_mem_odt                      			(memory_mem_odt),
		.memory_mem_dm                       			(memory_mem_dm),
		.memory_oct_rzqin                    			(memory_oct_rzqin),
    	.peripheral_hps_io_emac1_inst_MDIO   			(emac_mdio),
    	.peripheral_hps_io_emac1_inst_MDC    			(emac_mdc),
    	.peripheral_hps_io_emac1_inst_TX_CLK 			(emac_tx_clk),
    	.peripheral_hps_io_emac1_inst_TX_CTL 			(emac_tx_ctl),
    	.peripheral_hps_io_emac1_inst_TXD0   			(emac_txd[0]),
    	.peripheral_hps_io_emac1_inst_TXD1   			(emac_txd[1]),
    	.peripheral_hps_io_emac1_inst_TXD2   			(emac_txd[2]),
    	.peripheral_hps_io_emac1_inst_TXD3   			(emac_txd[3]),
    	.peripheral_hps_io_emac1_inst_RX_CLK 			(emac_rx_clk),
    	.peripheral_hps_io_emac1_inst_RX_CTL 			(emac_rx_ctl),
    	.peripheral_hps_io_emac1_inst_RXD0   			(emac_rxd[0]),
    	.peripheral_hps_io_emac1_inst_RXD1   			(emac_rxd[1]),
    	.peripheral_hps_io_emac1_inst_RXD2   			(emac_rxd[2]),
    	.peripheral_hps_io_emac1_inst_RXD3   			(emac_rxd[3]),
    	.peripheral_hps_io_sdio_inst_CMD     			(sd_cmd),
    	.peripheral_hps_io_sdio_inst_CLK     			(sd_clk),
    	.peripheral_hps_io_sdio_inst_D0      			(sd_d[0]),
    	.peripheral_hps_io_sdio_inst_D1      			(sd_d[1]),
    	.peripheral_hps_io_sdio_inst_D2      			(sd_d[2]),
    	.peripheral_hps_io_sdio_inst_D3      			(sd_d[3]),
    	.peripheral_hps_io_uart0_inst_RX     			(uart_rx),
    	.peripheral_hps_io_uart0_inst_TX     			(uart_tx),
    	.peripheral_hps_io_gpio_inst_GPIO56  			(led[3]),
    	.peripheral_hps_io_gpio_inst_GPIO55  			(led[2]),
    	.peripheral_hps_io_gpio_inst_GPIO54  			(led[1]),
    	.peripheral_hps_io_gpio_inst_GPIO53  			(led[0])
	);
 
  	// module for visualizing the kernel clock with 4 LEDs
  	reg [29:0] count;
  	
	always@(posedge kernel_clk)
		count <= count + 1'b1;
  
	assign fpga_led_output[3:0] = ~count[29:26];  

endmodule

