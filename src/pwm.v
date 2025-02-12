`timescale 1ns / 1ps

module pwm (
    input clk,          // 50MHz clock input
    input rst,          // Reset signal
    input [2:0] sw,     // 3 switches for duty cycle control
    output reg pwm_out  // PWM output signal
);

    reg [3:0] counter;  // 4-bit counter for PWM timing (0 to 9)
    reg [3:0] duty_cycle; // 4-bit duty cycle register (0 to 8, representing 10% to 80%)

    // Duty cycle control logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            duty_cycle <= 0; // Reset duty cycle to 10% (default)
        end else begin
            // Set duty cycle based on switch combinations
            case (sw)
                3'b000: duty_cycle <= 1; // 10% duty cycle
                3'b001: duty_cycle <= 2; // 20% duty cycle
                3'b010: duty_cycle <= 3; // 30% duty cycle
                3'b011: duty_cycle <= 4; // 40% duty cycle
                3'b100: duty_cycle <= 5; // 50% duty cycle
                3'b101: duty_cycle <= 6; // 60% duty cycle
                3'b110: duty_cycle <= 7; // 70% duty cycle
                3'b111: duty_cycle <= 8; // 80% duty cycle
                default: duty_cycle <= 1; // Default to 10% if invalid input
            endcase
        end
    end

    // Counter logic for PWM signal generation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
        end else begin
            if (counter == 9) begin
                counter <= 0; // Reset counter after reaching 9
            end else begin
                counter <= counter + 1; // Increment counter
            end
        end
    end

    // PWM signal generation logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pwm_out <= 0;
        end else begin
            if (counter < duty_cycle) begin
                pwm_out <= 1; // Set PWM output HIGH
            end else begin
                pwm_out <= 0; // Set PWM output LOW
            end
        end
    end

endmodule