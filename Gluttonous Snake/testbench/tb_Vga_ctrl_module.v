module tb_Vga_ctrl_module();

    // --------------- Inputs ----------------
    reg Clk_25mhz;          // 25 MHz 时钟
    reg Rst_n;              // 全局复位信号
    reg [1:0] Object;       // 当前扫描对象：00：NONE；01：HEAD；10：BODY；11：WALL；
    reg [5:0] Apple_x;      // 苹果的 X 坐标
    reg [4:0] Apple_y;      // 苹果的 Y 坐标
    reg Apple_type;         // 苹果类型（红色=0，绿色=1）

    // --------------- Outputs ----------------
    wire [9:0] Pixel_x;     // 当前像素的 X 坐标
    wire [9:0] Pixel_y;     // 当前像素的 Y 坐标
    wire Hsync_sig;         // 列同步信号
    wire Vsync_sig;         // 场同步信号
    wire play_VGA_red;      // VGA 红色分量
    wire play_VGA_green;    // VGA 绿色分量
    wire play_VGA_blue;     // VGA 蓝色分量

    // --------------- Instantiate the Unit Under Test (UUT) ----------------
    Vga_ctrl_module uut (
        .Clk_25mhz(Clk_25mhz),
        .Rst_n(Rst_n),
        .Object(Object),
        .Apple_x(Apple_x),
        .Apple_y(Apple_y),
        .Apple_type(Apple_type),
        .Pixel_x(Pixel_x),
        .Pixel_y(Pixel_y),
        .Hsync_sig(Hsync_sig),
        .Vsync_sig(Vsync_sig),
        .play_VGA_red(play_VGA_red),
        .play_VGA_green(play_VGA_green),
        .play_VGA_blue(play_VGA_blue)
    );

    // --------------- Clock Generation ----------------
    always begin
        Clk_25mhz = 0; #20; // 每 20 时间单位反转一次时钟（25MHz 时钟周期）
        Clk_25mhz = 1; #20;
    end

    // --------------- Stimulus ----------------
    initial begin
        // 初始复位
        Rst_n = 0;
        Object = 2'b00; // 默认没有物体
        Apple_x = 6'd10; // 苹果位置 X 坐标
        Apple_y = 5'd10; // 苹果位置 Y 坐标
        Apple_type = 1'b0; // 红色苹果
        #50; // 施加复位
        Rst_n = 1; // 解除复位

        // 模拟几个扫描周期
        #1000;

        // 测试蛇头
        Object = 2'b01; // 蛇头
        #2000;

        // 测试蛇身
        Object = 2'b10; // 蛇身
        #2000;

        // 测试墙壁
        Object = 2'b11; // 墙壁
        #2000;

        // 测试苹果
        Object = 2'b00; // 没有物体
        Apple_x = 6'd20;
        Apple_y = 5'd15;
        Apple_type = 1'b1; // 绿色苹果
        #2000;

        // 结束仿真
        $finish;
    end

    // --------------- Monitor ----------------
    initial begin
        $monitor("At time %t, Pixel_x = %d, Pixel_y = %d, Hsync = %b, Vsync = %b, Red = %b, Green = %b, Blue = %b", 
                 $time, Pixel_x, Pixel_y, Hsync_sig, Vsync_sig, play_VGA_red, play_VGA_green, play_VGA_blue);
    end

endmodule
