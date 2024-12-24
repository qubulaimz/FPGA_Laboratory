module start_top		
(								
	input CLK_40M,				
	input RSTn,					
	
	output start_Vga_green,		
	output start_Vga_blue,			
	output start_Vga_red,
	output start_Hsync_sig,
	output start_Vsync_sig
);
	//**************************************************************

	//**************************************************************
	wire [10:0] Row_add;
	wire [10:0] Rom_add; 	
	wire [255:0] Rom_data;	
	wire [10:0] Column_add;
	wire start_Ready_sig;	
	start_Vga_sync	U2
	(
		.CLK_40M(CLK_40M),
		.RSTn(RSTn),
		.start_Hsync_sig(start_Hsync_sig),
		.start_Vsync_sig(start_Vsync_sig),
		.start_Ready_sig(start_Ready_sig),
		.Row_add(Row_add),
		.Column_add(Column_add)
	);

	//**************************************************************
	start_Vga_control	U3
	(
		.CLK_40M(CLK_40M),
		.RSTn(RSTn),
		.start_Ready_sig(start_Ready_sig),
		.Row_add(Row_add),
		.Column_add(Column_add),
		.start_Vga_red(start_Vga_red),
		.start_Vga_green(start_Vga_green),
		
		.Rom_add(Rom_add),
		.Rom_data(Rom_data),
		
		.start_Vga_blue(start_Vga_blue)
	);
	//**************************************************************	
	
	ex5_start_rom	U4 
	(
		.address(Rom_add),
		.clock(CLK_40M),
		.q(Rom_data)
	);
		

endmodule 
