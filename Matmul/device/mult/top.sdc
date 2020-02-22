# 50MHz board input clock
create_clock -period 20 [get_ports fpga_clk_50]

# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdo]

# HPS peripherals port false path setting to workaround the unconstraint path (setting false_path for hps_0 ports will not affect the routing as it is hard silicon)
set_false_path -from [get_ports {emac_mdio}] -to *
set_false_path -from [get_ports {emac_rx_clk}] -to *
set_false_path -from [get_ports {emac_rx_ctl}] -to *
set_false_path -from [get_ports {emac_rxd[0]}] -to *
set_false_path -from [get_ports {emac_rxd[1]}] -to *
set_false_path -from [get_ports {emac_rxd[2]}] -to *
set_false_path -from [get_ports {emac_rxd[3]}] -to *
set_false_path -from [get_ports {led[0]}] -to *
set_false_path -from [get_ports {led[1]}] -to *
set_false_path -from [get_ports {led[2]}] -to *
set_false_path -from [get_ports {led[3]}] -to *
set_false_path -from [get_ports {sd_cmd}] -to *
set_false_path -from [get_ports {sd_d[0]}] -to *
set_false_path -from [get_ports {sd_d[1]}] -to *
set_false_path -from [get_ports {sd_d[2]}] -to *
set_false_path -from [get_ports {sd_d[3]}] -to *
set_false_path -from [get_ports {uart_rx}] -to *

set_false_path -from * -to [get_ports {emac_mdc}] 
set_false_path -from * -to [get_ports {emac_mdio}]
set_false_path -from * -to [get_ports {emac_tx_clk}]
set_false_path -from * -to [get_ports {emac_tx_ctl}]
set_false_path -from * -to [get_ports {emac_txd[0]}]
set_false_path -from * -to [get_ports {emac_txd[1]}]
set_false_path -from * -to [get_ports {emac_txd[2]}]
set_false_path -from * -to [get_ports {emac_txd[3]}]
set_false_path -from * -to [get_ports {led[0]}]
set_false_path -from * -to [get_ports {led[1]}]
set_false_path -from * -to [get_ports {led[2]}]
set_false_path -from * -to [get_ports {led[3]}]
set_false_path -from * -to [get_ports {sd_clk}]
set_false_path -from * -to [get_ports {sd_cmd}]
set_false_path -from * -to [get_ports {sd_d[0]}]
set_false_path -from * -to [get_ports {sd_d[1]}]
set_false_path -from * -to [get_ports {sd_d[2]}]
set_false_path -from * -to [get_ports {sd_d[3]}]
set_false_path -from * -to [get_ports {uart_tx}]

# Qsys will synchronize the reset input
set_false_path -from [get_ports fpga_reset_n] -to *

# LED switching will be slow
set_false_path -from * -to [get_ports fpga_led_output[*]]
set_false_path -from {system:the_system|system_acl_iface:acl_iface|system_acl_iface_acl_kernel_clk:acl_kernel_clk|timer:counter|counter2x_a[15]} -to *
set_false_path -from {system:the_system|system_acl_iface:acl_iface|system_acl_iface_acl_kernel_clk:acl_kernel_clk|timer:counter|counter_a[15]} -to *

# fix for stability of FPGA DDR accesses
if {$::quartus(nameofexecutable) == "quartus_fit"} {
  set_min_delay -from system:the_system|system_fpga_sdram:fpga_sdram|altera_mem_if_hard_memory_controller_top_cyclonev:c0|hmc_inst~FF_* 0.5
  set_min_delay -to system:the_system|system_fpga_sdram:fpga_sdram|altera_mem_if_hard_memory_controller_top_cyclonev:c0|hmc_inst~FF_* 1.0
}

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks

#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty

