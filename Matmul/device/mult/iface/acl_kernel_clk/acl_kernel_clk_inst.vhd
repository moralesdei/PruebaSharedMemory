	component acl_kernel_clk is
		port (
			kernel_clk2x_clk         : out std_logic;                                        -- clk
			pll_refclk_clk           : in  std_logic                     := 'X';             -- clk
			ctrl_waitrequest         : out std_logic;                                        -- waitrequest
			ctrl_readdata            : out std_logic_vector(31 downto 0);                    -- readdata
			ctrl_readdatavalid       : out std_logic;                                        -- readdatavalid
			ctrl_burstcount          : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- burstcount
			ctrl_writedata           : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			ctrl_address             : in  std_logic_vector(10 downto 0) := (others => 'X'); -- address
			ctrl_write               : in  std_logic                     := 'X';             -- write
			ctrl_read                : in  std_logic                     := 'X';             -- read
			ctrl_byteenable          : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			ctrl_debugaccess         : in  std_logic                     := 'X';             -- debugaccess
			kernel_clk_clk           : out std_logic;                                        -- clk
			kernel_pll_locked_export : out std_logic;                                        -- export
			clk_clk                  : in  std_logic                     := 'X';             -- clk
			reset_reset_n            : in  std_logic                     := 'X'              -- reset_n
		);
	end component acl_kernel_clk;

	u0 : component acl_kernel_clk
		port map (
			kernel_clk2x_clk         => CONNECTED_TO_kernel_clk2x_clk,         --      kernel_clk2x.clk
			pll_refclk_clk           => CONNECTED_TO_pll_refclk_clk,           --        pll_refclk.clk
			ctrl_waitrequest         => CONNECTED_TO_ctrl_waitrequest,         --              ctrl.waitrequest
			ctrl_readdata            => CONNECTED_TO_ctrl_readdata,            --                  .readdata
			ctrl_readdatavalid       => CONNECTED_TO_ctrl_readdatavalid,       --                  .readdatavalid
			ctrl_burstcount          => CONNECTED_TO_ctrl_burstcount,          --                  .burstcount
			ctrl_writedata           => CONNECTED_TO_ctrl_writedata,           --                  .writedata
			ctrl_address             => CONNECTED_TO_ctrl_address,             --                  .address
			ctrl_write               => CONNECTED_TO_ctrl_write,               --                  .write
			ctrl_read                => CONNECTED_TO_ctrl_read,                --                  .read
			ctrl_byteenable          => CONNECTED_TO_ctrl_byteenable,          --                  .byteenable
			ctrl_debugaccess         => CONNECTED_TO_ctrl_debugaccess,         --                  .debugaccess
			kernel_clk_clk           => CONNECTED_TO_kernel_clk_clk,           --        kernel_clk.clk
			kernel_pll_locked_export => CONNECTED_TO_kernel_pll_locked_export, -- kernel_pll_locked.export
			clk_clk                  => CONNECTED_TO_clk_clk,                  --               clk.clk
			reset_reset_n            => CONNECTED_TO_reset_reset_n             --             reset.reset_n
		);

