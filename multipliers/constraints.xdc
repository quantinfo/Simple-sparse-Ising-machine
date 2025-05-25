### USER LEDS
set_property PACKAGE_PIN AR11 [ get_ports "W_LED_0" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "W_LED_0" ]

set_property PACKAGE_PIN AW10 [ get_ports "W_LED_1" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "W_LED_1" ]

set_property PACKAGE_PIN AT11 [ get_ports "W_LED_2" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "W_LED_2" ]

set_property PACKAGE_PIN AU10 [ get_ports "W_LED_3" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "W_LED_3" ]

#set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -hier]

set_property PACKAGE_PIN AM15			[get_ports "SYS_CLK_100M_P"]
set_property PACKAGE_PIN AN15			[get_ports "SYS_CLK_100M_N"]
set_property IOSTANDARD LVDS		[get_ports "SYS_CLK_100M_P"]
set_property IOSTANDARD LVDS		[get_ports "SYS_CLK_100M_N"]