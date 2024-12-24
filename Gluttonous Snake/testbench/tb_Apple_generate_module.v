`timescale 1ns / 1ps

module tb_Apple_generate_module;

  // Inputs
  reg Clk_50mhz;
  reg Rst_n;
  reg [5:0] Head_x;
  reg [5:0] Head_y;

  // Outputs
  wire [5:0] Apple_x;
  wire [4:0] Apple_y;
  wire Apple_type;
  wire Body_add_sig;

  // Instantiate the Apple_generate_module
  Apple_generate_module uut (
    .Clk_50mhz(Clk_50mhz),
    .Rst_n(Rst_n),
    .Head_x(Head_x),
    .Head_y(Head_y),
    .Apple_x(Apple_x),
    .Apple_y(Apple_y),
    .Apple_type(Apple_type),
    .Body_add_sig(Body_add_sig)
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
    Head_x = 6'd28;  // Initialize snake's head position
    Head_y = 5'd13;  // Initialize snake's head position

    // Wait for global reset to finish
    #100;
    Rst_n = 1; // Release reset

    // Simulate some random movements of snake's head and see how the apple behaves
    #2000 Head_x = 6'd30; Head_y = 5'd14;
    #2000 Head_x = 6'd25; Head_y = 5'd15;
    #2000 Head_x = 6'd28; Head_y = 5'd16;
    #2000 Head_x = 6'd28; Head_y = 5'd13; // Snake head reaches apple's initial position

    // Simulate a few more cycles to observe the apple's position and body increase signal
    #10000;
    $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time = %t | Head_x = %d, Head_y = %d | Apple_x = %d, Apple_y = %d | Apple_type = %b | Body_add_sig = %b",
             $time, Head_x, Head_y, Apple_x, Apple_y, Apple_type, Body_add_sig);
  end

endmodule
