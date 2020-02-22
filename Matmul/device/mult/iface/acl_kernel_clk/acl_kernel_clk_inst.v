	acl_kernel_clk u0 (
		.kernel_clk2x_clk         (<connected-to-kernel_clk2x_clk>),         //      kernel_clk2x.clk
		.pll_refclk_clk           (<connected-to-pll_refclk_clk>),           //        pll_refclk.clk
		.ctrl_waitrequest         (<connected-to-ctrl_waitrequest>),         //              ctrl.waitrequest
		.ctrl_readdata            (<connected-to-ctrl_readdata>),            //                  .readdata
		.ctrl_readdatavalid       (<connected-to-ctrl_readdatavalid>),       //                  .readdatavalid
		.ctrl_burstcount          (<connected-to-ctrl_burstcount>),          //                  .burstcount
		.ctrl_writedata           (<connected-to-ctrl_writedata>),           //                  .writedata
		.ctrl_address             (<connected-to-ctrl_address>),             //                  .address
		.ctrl_write               (<connected-to-ctrl_write>),               //                  .write
		.ctrl_read                (<connected-to-ctrl_read>),                //                  .read
		.ctrl_byteenable          (<connected-to-ctrl_byteenable>),          //                  .byteenable
		.ctrl_debugaccess         (<connected-to-ctrl_debugaccess>),         //                  .debugaccess
		.kernel_clk_clk           (<connected-to-kernel_clk_clk>),           //        kernel_clk.clk
		.kernel_pll_locked_export (<connected-to-kernel_pll_locked_export>), // kernel_pll_locked.export
		.clk_clk                  (<connected-to-clk_clk>),                  //               clk.clk
		.reset_reset_n            (<connected-to-reset_reset_n>)             //             reset.reset_n
	);

