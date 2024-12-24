module end_Vga_control		// VGA控制模块，主要处理显示控制逻辑，包括图像显示、位置计算等
(
	input CLK_40M,           // 40MHz时钟信号
	input RSTn,              // 复位信号，低电平有效
	input end_Ready_sig,     // 图像显示准备完成信号
	
	input [10:0] Row_add,    // 行地址输入
	input [10:0] Column_add, // 列地址输入
	input [255:0] Rom_data,  // ROM数据输入，代表VGA的颜色信息
	output [10:0] Rom_add,   // ROM地址输出，用于查找颜色数据
	output end_Vga_red,      // VGA红色通道输出
	output end_Vga_green,    // VGA绿色通道输出
	output end_Vga_blue      // VGA蓝色通道输出
);

	reg [10:0] m;  // 行地址的寄存器
	reg [10:0] n;  // 列地址的寄存器

	// 在时钟上升沿或复位信号有效时触发
	always @ (posedge CLK_40M or negedge RSTn)
	begin
		if (!RSTn)  // 如果复位信号有效
			begin
				m <= 11'd 0;  // 行地址清零
				n <= 11'd 0;  // 列地址清零
			end
		else
			begin
				// 计算列地址，若满足显示条件，则更新列地址n
				// 检查当前列地址是否在指定的范围内
				n <= (end_Ready_sig && ((11'd0 + 11'd200) < Column_add ) && (Column_add < (11'd 256 + 11'd200)))?
				    (Column_add[10:0] - 11'd200) : 11'd 0;

				// 计算行地址，若满足显示条件，则更新行地址m
				// 检查当前行地址是否在指定的范围内
				m <= (end_Ready_sig && ((11'd0 + 11'd100) < Row_add ) && (Row_add < (11'd 256 + 11'd100)))?
				    (Row_add[10:0] - 11'd100) : 11'd 0;		
			end	
	end
	
	// 将行地址m作为ROM地址输出
	assign Rom_add = m;
	
	// VGA红色通道的输出逻辑
	// 如果显示准备完成且ROM数据满足条件，则红色通道输出为0
	assign end_Vga_red = (end_Ready_sig) ? ( (Rom_data[11'd 255 - n]) ? 1'b0 : 1'b0 ) : 1'd 0;

	// VGA绿色通道的输出逻辑
	// 如果显示准备完成且ROM数据满足条件，则绿色通道输出为0
	assign end_Vga_green = (end_Ready_sig) ? ( (Rom_data[11'd 255 - n]) ? 1'b0 : 1'b0 ) : 1'd 0;

	// VGA蓝色通道的输出逻辑
	// 如果显示准备完成且ROM数据满足条件，则蓝色通道输出为1或0
	assign end_Vga_blue = (end_Ready_sig) ? ( (Rom_data[11'd 255 - n]) ? 1'b1 : 1'b0 ) : 1'b0;
	// 需要注意的是，蓝色通道的输出使用的是Rom_data中的一个特定位
	// ****************************!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

endmodule 
