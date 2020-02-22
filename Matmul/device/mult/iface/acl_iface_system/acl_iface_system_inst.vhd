	component acl_iface_system is
		port (
			config_clk_clk                            : in    std_logic                      := 'X';             -- clk
			reset_n                                   : in    std_logic                      := 'X';             -- reset_n
			kernel_pll_refclk_clk                     : in    std_logic                      := 'X';             -- clk
			kernel_clk_clk                            : out   std_logic;                                         -- clk
			kernel_reset_reset_n                      : out   std_logic;                                         -- reset_n
			kernel_clk2x_clk                          : out   std_logic;                                         -- clk
			kernel_mem0_waitrequest                   : out   std_logic;                                         -- waitrequest
			kernel_mem0_readdata                      : out   std_logic_vector(255 downto 0);                    -- readdata
			kernel_mem0_readdatavalid                 : out   std_logic;                                         -- readdatavalid
			kernel_mem0_burstcount                    : in    std_logic_vector(4 downto 0)   := (others => 'X'); -- burstcount
			kernel_mem0_writedata                     : in    std_logic_vector(255 downto 0) := (others => 'X'); -- writedata
			kernel_mem0_address                       : in    std_logic_vector(29 downto 0)  := (others => 'X'); -- address
			kernel_mem0_write                         : in    std_logic                      := 'X';             -- write
			kernel_mem0_read                          : in    std_logic                      := 'X';             -- read
			kernel_mem0_byteenable                    : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- byteenable
			kernel_mem0_debugaccess                   : in    std_logic                      := 'X';             -- debugaccess
			acl_kernel_clk_kernel_pll_locked_export   : out   std_logic;                                         -- export
			kernel_clk_snoop_clk                      : out   std_logic;                                         -- clk
			memory_mem_a                              : out   std_logic_vector(14 downto 0);                     -- mem_a
			memory_mem_ba                             : out   std_logic_vector(2 downto 0);                      -- mem_ba
			memory_mem_ck                             : out   std_logic;                                         -- mem_ck
			memory_mem_ck_n                           : out   std_logic;                                         -- mem_ck_n
			memory_mem_cke                            : out   std_logic;                                         -- mem_cke
			memory_mem_cs_n                           : out   std_logic;                                         -- mem_cs_n
			memory_mem_ras_n                          : out   std_logic;                                         -- mem_ras_n
			memory_mem_cas_n                          : out   std_logic;                                         -- mem_cas_n
			memory_mem_we_n                           : out   std_logic;                                         -- mem_we_n
			memory_mem_reset_n                        : out   std_logic;                                         -- mem_reset_n
			memory_mem_dq                             : inout std_logic_vector(31 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs                            : inout std_logic_vector(3 downto 0)   := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                          : inout std_logic_vector(3 downto 0)   := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                            : out   std_logic;                                         -- mem_odt
			memory_mem_dm                             : out   std_logic_vector(3 downto 0);                      -- mem_dm
			memory_oct_rzqin                          : in    std_logic                      := 'X';             -- oct_rzqin
			peripheral_hps_io_emac1_inst_TX_CLK       : out   std_logic;                                         -- hps_io_emac1_inst_TX_CLK
			peripheral_hps_io_emac1_inst_TXD0         : out   std_logic;                                         -- hps_io_emac1_inst_TXD0
			peripheral_hps_io_emac1_inst_TXD1         : out   std_logic;                                         -- hps_io_emac1_inst_TXD1
			peripheral_hps_io_emac1_inst_TXD2         : out   std_logic;                                         -- hps_io_emac1_inst_TXD2
			peripheral_hps_io_emac1_inst_TXD3         : out   std_logic;                                         -- hps_io_emac1_inst_TXD3
			peripheral_hps_io_emac1_inst_RXD0         : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD0
			peripheral_hps_io_emac1_inst_MDIO         : inout std_logic                      := 'X';             -- hps_io_emac1_inst_MDIO
			peripheral_hps_io_emac1_inst_MDC          : out   std_logic;                                         -- hps_io_emac1_inst_MDC
			peripheral_hps_io_emac1_inst_RX_CTL       : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RX_CTL
			peripheral_hps_io_emac1_inst_TX_CTL       : out   std_logic;                                         -- hps_io_emac1_inst_TX_CTL
			peripheral_hps_io_emac1_inst_RX_CLK       : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RX_CLK
			peripheral_hps_io_emac1_inst_RXD1         : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD1
			peripheral_hps_io_emac1_inst_RXD2         : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD2
			peripheral_hps_io_emac1_inst_RXD3         : in    std_logic                      := 'X';             -- hps_io_emac1_inst_RXD3
			peripheral_hps_io_sdio_inst_CMD           : inout std_logic                      := 'X';             -- hps_io_sdio_inst_CMD
			peripheral_hps_io_sdio_inst_D0            : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D0
			peripheral_hps_io_sdio_inst_D1            : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D1
			peripheral_hps_io_sdio_inst_CLK           : out   std_logic;                                         -- hps_io_sdio_inst_CLK
			peripheral_hps_io_sdio_inst_D2            : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D2
			peripheral_hps_io_sdio_inst_D3            : inout std_logic                      := 'X';             -- hps_io_sdio_inst_D3
			peripheral_hps_io_uart0_inst_RX           : in    std_logic                      := 'X';             -- hps_io_uart0_inst_RX
			peripheral_hps_io_uart0_inst_TX           : out   std_logic;                                         -- hps_io_uart0_inst_TX
			peripheral_hps_io_gpio_inst_GPIO53        : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO53
			peripheral_hps_io_gpio_inst_GPIO54        : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO54
			peripheral_hps_io_gpio_inst_GPIO55        : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO55
			peripheral_hps_io_gpio_inst_GPIO56        : inout std_logic                      := 'X';             -- hps_io_gpio_inst_GPIO56
			acl_internal_memorg_kernel_mode           : out   std_logic_vector(1 downto 0);                      -- mode
			kernel_irq_irq                            : in    std_logic_vector(0 downto 0)   := (others => 'X'); -- irq
			kernel_cra_waitrequest                    : in    std_logic                      := 'X';             -- waitrequest
			kernel_cra_readdata                       : in    std_logic_vector(63 downto 0)  := (others => 'X'); -- readdata
			kernel_cra_readdatavalid                  : in    std_logic                      := 'X';             -- readdatavalid
			kernel_cra_burstcount                     : out   std_logic_vector(0 downto 0);                      -- burstcount
			kernel_cra_writedata                      : out   std_logic_vector(63 downto 0);                     -- writedata
			kernel_cra_address                        : out   std_logic_vector(29 downto 0);                     -- address
			kernel_cra_write                          : out   std_logic;                                         -- write
			kernel_cra_read                           : out   std_logic;                                         -- read
			kernel_cra_byteenable                     : out   std_logic_vector(7 downto 0);                      -- byteenable
			kernel_cra_debugaccess                    : out   std_logic;                                         -- debugaccess
			kernel_interface_acl_bsp_memorg_host_mode : out   std_logic_vector(1 downto 0)                       -- mode
		);
	end component acl_iface_system;

	u0 : component acl_iface_system
		port map (
			config_clk_clk                            => CONNECTED_TO_config_clk_clk,                            --                           config_clk.clk
			reset_n                                   => CONNECTED_TO_reset_n,                                   --                         global_reset.reset_n
			kernel_pll_refclk_clk                     => CONNECTED_TO_kernel_pll_refclk_clk,                     --                    kernel_pll_refclk.clk
			kernel_clk_clk                            => CONNECTED_TO_kernel_clk_clk,                            --                           kernel_clk.clk
			kernel_reset_reset_n                      => CONNECTED_TO_kernel_reset_reset_n,                      --                         kernel_reset.reset_n
			kernel_clk2x_clk                          => CONNECTED_TO_kernel_clk2x_clk,                          --                         kernel_clk2x.clk
			kernel_mem0_waitrequest                   => CONNECTED_TO_kernel_mem0_waitrequest,                   --                          kernel_mem0.waitrequest
			kernel_mem0_readdata                      => CONNECTED_TO_kernel_mem0_readdata,                      --                                     .readdata
			kernel_mem0_readdatavalid                 => CONNECTED_TO_kernel_mem0_readdatavalid,                 --                                     .readdatavalid
			kernel_mem0_burstcount                    => CONNECTED_TO_kernel_mem0_burstcount,                    --                                     .burstcount
			kernel_mem0_writedata                     => CONNECTED_TO_kernel_mem0_writedata,                     --                                     .writedata
			kernel_mem0_address                       => CONNECTED_TO_kernel_mem0_address,                       --                                     .address
			kernel_mem0_write                         => CONNECTED_TO_kernel_mem0_write,                         --                                     .write
			kernel_mem0_read                          => CONNECTED_TO_kernel_mem0_read,                          --                                     .read
			kernel_mem0_byteenable                    => CONNECTED_TO_kernel_mem0_byteenable,                    --                                     .byteenable
			kernel_mem0_debugaccess                   => CONNECTED_TO_kernel_mem0_debugaccess,                   --                                     .debugaccess
			acl_kernel_clk_kernel_pll_locked_export   => CONNECTED_TO_acl_kernel_clk_kernel_pll_locked_export,   --     acl_kernel_clk_kernel_pll_locked.export
			kernel_clk_snoop_clk                      => CONNECTED_TO_kernel_clk_snoop_clk,                      --                     kernel_clk_snoop.clk
			memory_mem_a                              => CONNECTED_TO_memory_mem_a,                              --                               memory.mem_a
			memory_mem_ba                             => CONNECTED_TO_memory_mem_ba,                             --                                     .mem_ba
			memory_mem_ck                             => CONNECTED_TO_memory_mem_ck,                             --                                     .mem_ck
			memory_mem_ck_n                           => CONNECTED_TO_memory_mem_ck_n,                           --                                     .mem_ck_n
			memory_mem_cke                            => CONNECTED_TO_memory_mem_cke,                            --                                     .mem_cke
			memory_mem_cs_n                           => CONNECTED_TO_memory_mem_cs_n,                           --                                     .mem_cs_n
			memory_mem_ras_n                          => CONNECTED_TO_memory_mem_ras_n,                          --                                     .mem_ras_n
			memory_mem_cas_n                          => CONNECTED_TO_memory_mem_cas_n,                          --                                     .mem_cas_n
			memory_mem_we_n                           => CONNECTED_TO_memory_mem_we_n,                           --                                     .mem_we_n
			memory_mem_reset_n                        => CONNECTED_TO_memory_mem_reset_n,                        --                                     .mem_reset_n
			memory_mem_dq                             => CONNECTED_TO_memory_mem_dq,                             --                                     .mem_dq
			memory_mem_dqs                            => CONNECTED_TO_memory_mem_dqs,                            --                                     .mem_dqs
			memory_mem_dqs_n                          => CONNECTED_TO_memory_mem_dqs_n,                          --                                     .mem_dqs_n
			memory_mem_odt                            => CONNECTED_TO_memory_mem_odt,                            --                                     .mem_odt
			memory_mem_dm                             => CONNECTED_TO_memory_mem_dm,                             --                                     .mem_dm
			memory_oct_rzqin                          => CONNECTED_TO_memory_oct_rzqin,                          --                                     .oct_rzqin
			peripheral_hps_io_emac1_inst_TX_CLK       => CONNECTED_TO_peripheral_hps_io_emac1_inst_TX_CLK,       --                           peripheral.hps_io_emac1_inst_TX_CLK
			peripheral_hps_io_emac1_inst_TXD0         => CONNECTED_TO_peripheral_hps_io_emac1_inst_TXD0,         --                                     .hps_io_emac1_inst_TXD0
			peripheral_hps_io_emac1_inst_TXD1         => CONNECTED_TO_peripheral_hps_io_emac1_inst_TXD1,         --                                     .hps_io_emac1_inst_TXD1
			peripheral_hps_io_emac1_inst_TXD2         => CONNECTED_TO_peripheral_hps_io_emac1_inst_TXD2,         --                                     .hps_io_emac1_inst_TXD2
			peripheral_hps_io_emac1_inst_TXD3         => CONNECTED_TO_peripheral_hps_io_emac1_inst_TXD3,         --                                     .hps_io_emac1_inst_TXD3
			peripheral_hps_io_emac1_inst_RXD0         => CONNECTED_TO_peripheral_hps_io_emac1_inst_RXD0,         --                                     .hps_io_emac1_inst_RXD0
			peripheral_hps_io_emac1_inst_MDIO         => CONNECTED_TO_peripheral_hps_io_emac1_inst_MDIO,         --                                     .hps_io_emac1_inst_MDIO
			peripheral_hps_io_emac1_inst_MDC          => CONNECTED_TO_peripheral_hps_io_emac1_inst_MDC,          --                                     .hps_io_emac1_inst_MDC
			peripheral_hps_io_emac1_inst_RX_CTL       => CONNECTED_TO_peripheral_hps_io_emac1_inst_RX_CTL,       --                                     .hps_io_emac1_inst_RX_CTL
			peripheral_hps_io_emac1_inst_TX_CTL       => CONNECTED_TO_peripheral_hps_io_emac1_inst_TX_CTL,       --                                     .hps_io_emac1_inst_TX_CTL
			peripheral_hps_io_emac1_inst_RX_CLK       => CONNECTED_TO_peripheral_hps_io_emac1_inst_RX_CLK,       --                                     .hps_io_emac1_inst_RX_CLK
			peripheral_hps_io_emac1_inst_RXD1         => CONNECTED_TO_peripheral_hps_io_emac1_inst_RXD1,         --                                     .hps_io_emac1_inst_RXD1
			peripheral_hps_io_emac1_inst_RXD2         => CONNECTED_TO_peripheral_hps_io_emac1_inst_RXD2,         --                                     .hps_io_emac1_inst_RXD2
			peripheral_hps_io_emac1_inst_RXD3         => CONNECTED_TO_peripheral_hps_io_emac1_inst_RXD3,         --                                     .hps_io_emac1_inst_RXD3
			peripheral_hps_io_sdio_inst_CMD           => CONNECTED_TO_peripheral_hps_io_sdio_inst_CMD,           --                                     .hps_io_sdio_inst_CMD
			peripheral_hps_io_sdio_inst_D0            => CONNECTED_TO_peripheral_hps_io_sdio_inst_D0,            --                                     .hps_io_sdio_inst_D0
			peripheral_hps_io_sdio_inst_D1            => CONNECTED_TO_peripheral_hps_io_sdio_inst_D1,            --                                     .hps_io_sdio_inst_D1
			peripheral_hps_io_sdio_inst_CLK           => CONNECTED_TO_peripheral_hps_io_sdio_inst_CLK,           --                                     .hps_io_sdio_inst_CLK
			peripheral_hps_io_sdio_inst_D2            => CONNECTED_TO_peripheral_hps_io_sdio_inst_D2,            --                                     .hps_io_sdio_inst_D2
			peripheral_hps_io_sdio_inst_D3            => CONNECTED_TO_peripheral_hps_io_sdio_inst_D3,            --                                     .hps_io_sdio_inst_D3
			peripheral_hps_io_uart0_inst_RX           => CONNECTED_TO_peripheral_hps_io_uart0_inst_RX,           --                                     .hps_io_uart0_inst_RX
			peripheral_hps_io_uart0_inst_TX           => CONNECTED_TO_peripheral_hps_io_uart0_inst_TX,           --                                     .hps_io_uart0_inst_TX
			peripheral_hps_io_gpio_inst_GPIO53        => CONNECTED_TO_peripheral_hps_io_gpio_inst_GPIO53,        --                                     .hps_io_gpio_inst_GPIO53
			peripheral_hps_io_gpio_inst_GPIO54        => CONNECTED_TO_peripheral_hps_io_gpio_inst_GPIO54,        --                                     .hps_io_gpio_inst_GPIO54
			peripheral_hps_io_gpio_inst_GPIO55        => CONNECTED_TO_peripheral_hps_io_gpio_inst_GPIO55,        --                                     .hps_io_gpio_inst_GPIO55
			peripheral_hps_io_gpio_inst_GPIO56        => CONNECTED_TO_peripheral_hps_io_gpio_inst_GPIO56,        --                                     .hps_io_gpio_inst_GPIO56
			acl_internal_memorg_kernel_mode           => CONNECTED_TO_acl_internal_memorg_kernel_mode,           --           acl_internal_memorg_kernel.mode
			kernel_irq_irq                            => CONNECTED_TO_kernel_irq_irq,                            --                           kernel_irq.irq
			kernel_cra_waitrequest                    => CONNECTED_TO_kernel_cra_waitrequest,                    --                           kernel_cra.waitrequest
			kernel_cra_readdata                       => CONNECTED_TO_kernel_cra_readdata,                       --                                     .readdata
			kernel_cra_readdatavalid                  => CONNECTED_TO_kernel_cra_readdatavalid,                  --                                     .readdatavalid
			kernel_cra_burstcount                     => CONNECTED_TO_kernel_cra_burstcount,                     --                                     .burstcount
			kernel_cra_writedata                      => CONNECTED_TO_kernel_cra_writedata,                      --                                     .writedata
			kernel_cra_address                        => CONNECTED_TO_kernel_cra_address,                        --                                     .address
			kernel_cra_write                          => CONNECTED_TO_kernel_cra_write,                          --                                     .write
			kernel_cra_read                           => CONNECTED_TO_kernel_cra_read,                           --                                     .read
			kernel_cra_byteenable                     => CONNECTED_TO_kernel_cra_byteenable,                     --                                     .byteenable
			kernel_cra_debugaccess                    => CONNECTED_TO_kernel_cra_debugaccess,                    --                                     .debugaccess
			kernel_interface_acl_bsp_memorg_host_mode => CONNECTED_TO_kernel_interface_acl_bsp_memorg_host_mode  -- kernel_interface_acl_bsp_memorg_host.mode
		);

