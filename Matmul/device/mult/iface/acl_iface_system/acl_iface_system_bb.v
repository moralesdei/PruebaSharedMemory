
module acl_iface_system (
	config_clk_clk,
	reset_n,
	kernel_pll_refclk_clk,
	kernel_clk_clk,
	kernel_reset_reset_n,
	kernel_clk2x_clk,
	kernel_mem0_waitrequest,
	kernel_mem0_readdata,
	kernel_mem0_readdatavalid,
	kernel_mem0_burstcount,
	kernel_mem0_writedata,
	kernel_mem0_address,
	kernel_mem0_write,
	kernel_mem0_read,
	kernel_mem0_byteenable,
	kernel_mem0_debugaccess,
	acl_kernel_clk_kernel_pll_locked_export,
	kernel_clk_snoop_clk,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	peripheral_hps_io_emac1_inst_TX_CLK,
	peripheral_hps_io_emac1_inst_TXD0,
	peripheral_hps_io_emac1_inst_TXD1,
	peripheral_hps_io_emac1_inst_TXD2,
	peripheral_hps_io_emac1_inst_TXD3,
	peripheral_hps_io_emac1_inst_RXD0,
	peripheral_hps_io_emac1_inst_MDIO,
	peripheral_hps_io_emac1_inst_MDC,
	peripheral_hps_io_emac1_inst_RX_CTL,
	peripheral_hps_io_emac1_inst_TX_CTL,
	peripheral_hps_io_emac1_inst_RX_CLK,
	peripheral_hps_io_emac1_inst_RXD1,
	peripheral_hps_io_emac1_inst_RXD2,
	peripheral_hps_io_emac1_inst_RXD3,
	peripheral_hps_io_sdio_inst_CMD,
	peripheral_hps_io_sdio_inst_D0,
	peripheral_hps_io_sdio_inst_D1,
	peripheral_hps_io_sdio_inst_CLK,
	peripheral_hps_io_sdio_inst_D2,
	peripheral_hps_io_sdio_inst_D3,
	peripheral_hps_io_uart0_inst_RX,
	peripheral_hps_io_uart0_inst_TX,
	peripheral_hps_io_gpio_inst_GPIO53,
	peripheral_hps_io_gpio_inst_GPIO54,
	peripheral_hps_io_gpio_inst_GPIO55,
	peripheral_hps_io_gpio_inst_GPIO56,
	acl_internal_memorg_kernel_mode,
	kernel_irq_irq,
	kernel_cra_waitrequest,
	kernel_cra_readdata,
	kernel_cra_readdatavalid,
	kernel_cra_burstcount,
	kernel_cra_writedata,
	kernel_cra_address,
	kernel_cra_write,
	kernel_cra_read,
	kernel_cra_byteenable,
	kernel_cra_debugaccess,
	kernel_interface_acl_bsp_memorg_host_mode);	

	input		config_clk_clk;
	input		reset_n;
	input		kernel_pll_refclk_clk;
	output		kernel_clk_clk;
	output		kernel_reset_reset_n;
	output		kernel_clk2x_clk;
	output		kernel_mem0_waitrequest;
	output	[255:0]	kernel_mem0_readdata;
	output		kernel_mem0_readdatavalid;
	input	[4:0]	kernel_mem0_burstcount;
	input	[255:0]	kernel_mem0_writedata;
	input	[29:0]	kernel_mem0_address;
	input		kernel_mem0_write;
	input		kernel_mem0_read;
	input	[31:0]	kernel_mem0_byteenable;
	input		kernel_mem0_debugaccess;
	output		acl_kernel_clk_kernel_pll_locked_export;
	output		kernel_clk_snoop_clk;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	output		peripheral_hps_io_emac1_inst_TX_CLK;
	output		peripheral_hps_io_emac1_inst_TXD0;
	output		peripheral_hps_io_emac1_inst_TXD1;
	output		peripheral_hps_io_emac1_inst_TXD2;
	output		peripheral_hps_io_emac1_inst_TXD3;
	input		peripheral_hps_io_emac1_inst_RXD0;
	inout		peripheral_hps_io_emac1_inst_MDIO;
	output		peripheral_hps_io_emac1_inst_MDC;
	input		peripheral_hps_io_emac1_inst_RX_CTL;
	output		peripheral_hps_io_emac1_inst_TX_CTL;
	input		peripheral_hps_io_emac1_inst_RX_CLK;
	input		peripheral_hps_io_emac1_inst_RXD1;
	input		peripheral_hps_io_emac1_inst_RXD2;
	input		peripheral_hps_io_emac1_inst_RXD3;
	inout		peripheral_hps_io_sdio_inst_CMD;
	inout		peripheral_hps_io_sdio_inst_D0;
	inout		peripheral_hps_io_sdio_inst_D1;
	output		peripheral_hps_io_sdio_inst_CLK;
	inout		peripheral_hps_io_sdio_inst_D2;
	inout		peripheral_hps_io_sdio_inst_D3;
	input		peripheral_hps_io_uart0_inst_RX;
	output		peripheral_hps_io_uart0_inst_TX;
	inout		peripheral_hps_io_gpio_inst_GPIO53;
	inout		peripheral_hps_io_gpio_inst_GPIO54;
	inout		peripheral_hps_io_gpio_inst_GPIO55;
	inout		peripheral_hps_io_gpio_inst_GPIO56;
	output	[1:0]	acl_internal_memorg_kernel_mode;
	input	[0:0]	kernel_irq_irq;
	input		kernel_cra_waitrequest;
	input	[63:0]	kernel_cra_readdata;
	input		kernel_cra_readdatavalid;
	output	[0:0]	kernel_cra_burstcount;
	output	[63:0]	kernel_cra_writedata;
	output	[29:0]	kernel_cra_address;
	output		kernel_cra_write;
	output		kernel_cra_read;
	output	[7:0]	kernel_cra_byteenable;
	output		kernel_cra_debugaccess;
	output	[1:0]	kernel_interface_acl_bsp_memorg_host_mode;
endmodule
