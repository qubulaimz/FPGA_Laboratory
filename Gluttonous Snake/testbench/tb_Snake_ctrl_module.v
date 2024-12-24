module tb_Snake_ctrl_module;

  // 参数定义
  reg Clk_50mhz;             // 50 MHz 时钟
  reg Rst_n;                 // 复位信号
  reg Key_left, Key_right, Key_up, Key_down; // 按键输入
  reg [9:0] Pixel_x, Pixel_y;  // 坐标输入
  reg Body_add_sig;          // 身体增长信号
  reg [2:0] Game_status;     // 游戏状态
  reg Flash_sig;             // 闪动信号
  
  wire [1:0] Object;         // 输出：当前扫描的对象
  wire [5:0] Head_x, Head_y; // 输出：蛇头的坐标
  wire Hit_body_sig;         // 输出：撞到身体信号
  wire Hit_wall_sig;         // 输出：撞到墙信号

  // 初始化信号
  initial begin
    Clk_50mhz = 0;
    Rst_n = 0;
    Key_left = 0;
    Key_right = 0;
    Key_up = 0;
    Key_down = 0;
    Pixel_x = 10'd5; // 设定一个默认的像素位置
    Pixel_y = 10'd5;
    Body_add_sig = 0;
    Game_status = 3'b001; // START 状态
    Flash_sig = 0;
    
    // 模拟复位信号
    #5 Rst_n = 1; // 5 个时间单位后解除复位
  end

  // 时钟生成
  always #10 Clk_50mhz = ~Clk_50mhz; // 50 MHz 时钟周期为 20 ns

  // 测试过程
  initial begin
    // 模拟游戏开始状态
    #10 Game_status = 3'b010; // 进入 PLAY 状态

    // 模拟按键输入
    #20 Key_right = 1; // 按右键
    #20 Key_right = 0; // 释放右键

    #20 Key_up = 1;    // 按上键
    #20 Key_up = 0;    // 释放上键

    #20 Key_left = 1;  // 按左键
    #20 Key_left = 0;  // 释放左键

    #20 Key_down = 1;  // 按下键
    #20 Key_down = 0;  // 释放下键

    // 模拟吃到苹果
    #20 Body_add_sig = 1; // 吃到苹果
    #20 Body_add_sig = 0; // 停止吃苹果

    // 模拟游戏结束状态
    #20 Game_status = 3'b100; // 进入 END 状态
  end
  
  // 实例化 Snake_ctrl_module
  Snake_ctrl_module uut (
    .Clk_50mhz(Clk_50mhz),
    .Rst_n(Rst_n),
    .Key_left(Key_left),
    .Key_right(Key_right),
    .Key_up(Key_up),
    .Key_down(Key_down),
    .Object(Object),
    .Pixel_x(Pixel_x),
    .Pixel_y(Pixel_y),
    .Head_x(Head_x),
    .Head_y(Head_y),
    .Body_add_sig(Body_add_sig),
    .Game_status(Game_status),
    .Hit_body_sig(Hit_body_sig),
    .Hit_wall_sig(Hit_wall_sig),
    .Flash_sig(Flash_sig)
  );

endmodule
