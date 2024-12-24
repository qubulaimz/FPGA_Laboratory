module end_top		
(								
	input CLK_40M,					
	input RSTn,					

	output end_Vga_green,			
	output end_Vga_blue,			
	output end_Vga_red,
	output end_Hsync_sig,
	output end_Vsync_sig
);
	//**************************************************************
	//**************************************************************
	wire [10:0] Row_add;
	wire [255:0] Rom_data;
	wire [10:0] Rom_add; 	
	wire [10:0] Column_add;
	wire end_Ready_sig;	
	end_Vga_sync	U2
	(
		.CLK_40M(CLK_40M),
		.RSTn(RSTn),
		.end_Hsync_sig(end_Hsync_sig),
		.end_Vsync_sig(end_Vsync_sig),
		.end_Ready_sig(end_Ready_sig),
		.Row_add(Row_add),
		.Column_add(Column_add)
	);

	//**************************************************************
	end_Vga_control	U3
	(
		.CLK_40M(CLK_40M),
		.RSTn(RSTn),
		.end_Ready_sig(end_Ready_sig),
		.Row_add(Row_add),
		.Column_add(Column_add),
		.end_Vga_red(end_Vga_red),
		.end_Vga_green(end_Vga_green),

//		.Flash_over_sig(Flash_over_sig),
		
		.Rom_add(Rom_add),
		.Rom_data(Rom_data),
		
		.end_Vga_blue(end_Vga_blue)
	);
	//**************************************************************	
	

	ex5_over_rom	U4 
	(
		.address(Rom_add),
		.clock(CLK_40M),
		.q(Rom_data)
	);


endmodule 
