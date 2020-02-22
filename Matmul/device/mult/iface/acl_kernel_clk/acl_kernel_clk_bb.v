
module acl_kernel_clk (
	kernel_clk2x_clk,
	pll_refclk_clk,
	ctrl_waitrequest,
	ctrl_readdata,
	ctrl_readdatavalid,
	ctrl_burstcount,
	ctrl_writedata,
	ctrl_address,
	ctrl_write,
	ctrl_read,
	ctrl_byteenable,
	ctrl_debugaccess,
	kernel_clk_clk,
	kernel_pll_locked_export,
	clk_clk,
	reset_reset_n);	

	output		kernel_clk2x_clk;
	input		pll_refclk_clk;
	output		ctrl_waitrequest;
	output	[31:0]	ctrl_readdata;
	output		ctrl_readdatavalid;
	input	[0:0]	ctrl_burstcount;
	input	[31:0]	ctrl_writedata;
	input	[10:0]	ctrl_address;
	input		ctrl_write;
	input		ctrl_read;
	input	[3:0]	ctrl_byteenable;
	input		ctrl_debugaccess;
	output		kernel_clk_clk;
	output		kernel_pll_locked_export;
	input		clk_clk;
	input		reset_reset_n;
endmodule
