`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate your module:
  tt_um_nithishreddykvs user_project (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk; // 50 MHz clock (20 ns period)
  end

  // Testbench logic
  initial begin
    // Initialize inputs
    rst_n = 0;  // Assert reset (active low)
    ui_in = 8'b00000000; // Set switches to 0 (10% duty cycle)
    uio_in = 8'b00000000; // Unused inputs
    #100;       // Wait for 100 ns

    // De-assert reset
    rst_n = 1;
    #1000;      // Wait for 1 us to stabilize

    // Test different duty cycles
    ui_in = 8'b00000001; // 20% duty cycle
    #1000;      // Wait for 1 us

    ui_in = 8'b00000010; // 30% duty cycle
    #1000;      // Wait for 1 us

    ui_in = 8'b00000011; // 40% duty cycle
    #1000;      // Wait for 1 us

    ui_in = 8'b00000100; // 50% duty cycle
    #1000;      // Wait for 1 us

    ui_in = 8'b00000101; // 60% duty cycle
    #1000;      // Wait for 1 us

    ui_in = 8'b00000110; // 70% duty cycle
    #1000;      // Wait for 1 us

    ui_in = 8'b00000111; // 80% duty cycle
    #1000;      // Wait for 1 us

    // End simulation
    $finish;
  end

endmodule
