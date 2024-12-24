module start_top		//VGAͼ����ʾ����ģ�飬����Ҫע�������������ǰ��ӵ�ԭʼʱ�ӣ�û����PLL��Ƶ��ʱ�ӣ�
(								//����Ҫע�⣬����Ҫ��ʾ�����磩256x256��ͼ����Ҫ�޸ĵĵط���
	input CLK_40M,					//1������µ�mif�ļ�
	input RSTn,					//2���ı�ԭ���Rom��λ��
	
	output start_Vga_green,			//3���޸�Vga_control������λ��
	output start_Vga_blue,			//4����ԭ���Rom�趨�������µ�mif�ļ�
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