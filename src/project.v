/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_nithishreddykvs (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;
  assign uo_out[0] = PWM_OUT;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:2], uio_in[7:0], rst_n};

	
 wire slow_clk_enable; // slow clock enable signal for debouncing FFs
 reg[27:0] counter_debounce=0;// counter for creating slow clock enable signals 
 wire tmp1,tmp2,duty_inc;// temporary flip-flop signals for debouncing the increasing button
 wire tmp3,tmp4,duty_dec;// temporary flip-flop signals for debouncing the decreasing button
 reg[3:0] counter_PWM=0;// counter for creating 10Mhz PWM signal
 reg[3:0] DUTY_CYCLE=5; // initial duty cycle is 50%
  // Debouncing 2 buttons for inc/dec duty cycle 
  // Firstly generate slow clock enable for debouncing flip-flop (4Hz)
 always @(posedge clk)
 begin
   counter_debounce <= counter_debounce + 1;
   //if(counter_debounce>=25000000) then  
   // for running on FPGA -- comment when running simulation
   if(counter_debounce>=1) 
   // for running simulation -- comment when running on FPGA
    counter_debounce <= 0;
 end
 // assign slow_clk_enable = counter_debounce == 25000000 ?1:0;
 // for running on FPGA -- comment when running simulation 
 assign slow_clk_enable = counter_debounce == 1 ?1:0;
 // for running simulation -- comment when running on FPGA
 // debouncing FFs for increasing button
	DFF_PWM PWM_DFF1(clk,slow_clk_enable,ui_in[0],tmp1);
 DFF_PWM PWM_DFF2(clk,slow_clk_enable,tmp1, tmp2); 
 assign duty_inc =  tmp1 & (~ tmp2) & slow_clk_enable;
 // debouncing FFs for decreasing button
	DFF_PWM PWM_DFF3(clk,slow_clk_enable,ui_in[1], tmp3);
 DFF_PWM PWM_DFF4(clk,slow_clk_enable,tmp3, tmp4); 
 assign duty_dec =  tmp3 & (~ tmp4) & slow_clk_enable;
 // vary the duty cycle using the debounced buttons above
 always @(posedge clk)
 begin
   if(duty_inc==1 && DUTY_CYCLE <= 9) 
    DUTY_CYCLE <= DUTY_CYCLE + 1;// increase duty cycle by 10%
   else if(duty_dec==1 && DUTY_CYCLE>=1) 
    DUTY_CYCLE <= DUTY_CYCLE - 1;//decrease duty cycle by 10%
 end 
// Create 10MHz PWM signal with variable duty cycle controlled by 2 buttons 
 always @(posedge clk)
 begin
   counter_PWM <= counter_PWM + 1;
   if(counter_PWM>=9) 
    counter_PWM <= 0;
 end
 assign PWM_OUT = counter_PWM < DUTY_CYCLE ? 1:0;
endmodule
// Debouncing DFFs for push buttons on FPGA
module DFF_PWM(clk,en,D,Q);
input clk,en,D;
output reg Q;
always @(posedge clk)
begin 
 if(en==1) // slow clock enable signal 
  Q <= D;
end 	
   

endmodule
