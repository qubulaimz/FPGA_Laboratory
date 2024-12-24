module end_top		//VGAͼ����ʾ����ģ�飬����Ҫע�������������ǰ��ӵ�ԭʼʱ�ӣ�û����PLL��Ƶ��ʱ�ӣ�
(								//����Ҫע�⣬����Ҫ��ʾ�����磩256x256��ͼ����Ҫ�޸ĵĵط���
	input CLK_40M,					//1������µ�mif�ļ�
	input RSTn,					//2���ı�ԭ���Rom��λ��

	output end_Vga_green,			//3���޸�Vga_control������λ��
	output end_Vga_blue,			//4����ԭ���Rom�趨�������µ�mif�ļ�
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