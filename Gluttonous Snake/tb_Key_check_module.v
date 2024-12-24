`timescale 1ns / 1ps

module tb_Key_check_module;

  // Inputs
  reg Clk_50mhz;
  reg Rst_n;
  reg Left;
  reg Right;
  reg Up;
  reg Down;

  // Outputs
  wire Key_left;
  wire Key_right;
  wire Key_up;
  wire Key_down;

  // Instantiate the Key_check_module
  Key_check_module uut (
    .Clk_50mhz(Clk_50mhz),
    .Rst_n(Rst_n),
    .Left(Left),
    .Right(Right),
    .Up(Up),
    .Down(Down),
    .Key_left(Key_left),
    .Key_right(Key_right),
    .Key_up(Key_up),
    .Key_down(Key_down)
  );

  // Clock generation
  always begin
    #10 Clk_50mhz = ~Clk_50mhz;  // 50MHz clock
  end

  // Stimulus
  initial begin
    // Initialize Inputs
    Clk_50mhz = 0;
    Rst_n = 0;
    Left = 0;
    Right = 0;
    Up = 0;
    Down = 0;

    // Wait for global reset to finish
    #100;
    Rst_n = 1; // Release reset

    // Test pressing and releasing Left key
    #2000 Left = 1; // Press Left key
    #100000 Left = 0; // Release Left key

    // Test pressing and releasing Right key
    #2000 Right = 1; // Press Right key
    #100000 Right = 0; // Release Right key

    // Test pressing and releasing Up key
    #2000 Up = 1; // Press Up key
    #100000 Up = 0; // Release Up key

    // Test pressing and releasing Down key
    #2000 Down = 1; // Press Down key
    #100000 Down = 0; // Release Down key

    // Simulate a longer period to observe debouncing behavior
    #20000;
    $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time = %t | Left = %b, Right = %b, Up = %b, Down = %b | Key_left = %b, Key_right = %b, Key_up = %b, Key_down = %b",
             $time, Left, Right, Up, Down, Key_left, Key_right, Key_up, Key_down);
  end

endmodule
