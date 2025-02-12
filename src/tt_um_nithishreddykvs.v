/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_nithishreddykvs (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Internal signals
  reg [2:0] sw;       // 3 switches for duty cycle control
  reg pwm_out;         // PWM output signal

  // Instantiate the PWM module
  pwm pwm_inst (
      .clk(clk),
      .rst(~rst_n),    // Invert rst_n to match active high reset
      .sw(sw),
      .pwm_out(pwm_out)
  );

  // Map the switches to the first 3 bits of ui_in
  always @(*) begin
      sw = ui_in[2:0];
  end

  // Map the PWM output to the first bit of uo_out
  assign uo_out = {7'b0, pwm_out};

  // Unused outputs
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
