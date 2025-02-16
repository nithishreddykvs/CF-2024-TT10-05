![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# PWM Generator with Adjustable Duty Cycle

This project implements a **Pulse Width Modulation (PWM) generator** with a variable duty cycle using Verilog. The duty cycle can be adjusted dynamically via user input buttons, ranging from 0% to 90% in 10% increments. The design is intended for FPGA implementation and operates on a 50 MHz input clock, generating a 10 MHz PWM signal as the output.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Hardware Requirements](#hardware-requirements)
4. [Software Requirements](#software-requirements)
5. [How to Use](#how-to-use)
6. [Testing and Verification](#testing-and-verification)
7. [Credits and References](#credits-and-references)

---

## Project Overview

The PWM generator is designed for applications requiring adjustable duty cycle signals, such as motor control, LED dimming, or general-purpose waveform generation. The module uses debounced inputs to ensure stable operation and prevent unintended duty cycle changes caused by button bounce.

---

## Features

- **Adjustable Duty Cycle**: 0% to 90% in 10% increments.
- **Debouncing Logic**: Prevents false triggers from noisy button inputs.
- **Reset Signal**: Allows reinitialization of the system.
- **FPGA Compatibility**: Synthesizable and testable on FPGA boards.
- **Clock Input**: Operates with a 50 MHz clock input.

---

## Hardware Requirements

To test or implement this project, you need the following hardware:

1. FPGA Development Board (e.g., Xilinx Artix-7 or Intel Cyclone)
2. Two Push Buttons (for increasing and decreasing duty cycle)
3. Oscilloscope or Logic Analyzer (for waveform observation)
4. 50 MHz Clock Signal Source (onboard or external)
5. Output Device (e.g., LED, motor, or any PWM-compatible device)

---

## Software Requirements

1. **Verilog Simulator**: ModelSim, Vivado, or any preferred Verilog simulation tool.
2. **FPGA Development Environment**: Xilinx Vivado, Intel Quartus, or equivalent tools for synthesis and programming.
3. **Version Control**: Git (optional, for managing project files).

---

## How to Use

### Simulation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo-name/pwm-generator.git

2.Open the Verilog files in your preferred simulation tool.

3.Provide a 50 MHz clock signal and simulate the behavior of ui_in[0] and ui_in[1] to observe the output PWM waveform.

---

## FPGA Implementation
- Synthesize the design using your FPGA toolchain.
- Assign the following ports to GPIO pins on your FPGA board:
  - clk → Connect to a 50 MHz clock.
  - ui_in[0] → Button for increasing duty cycle.
  - ui_in[1] → Button for decreasing duty cycle.
  - PWM_OUT → Connect to an output device or oscilloscope.

- Program the FPGA and test the functionality.

---

## Testing and Verification

#### Simulation
- Use a testbench to simulate the Verilog module.
- Check the PWM_OUT signal on waveform viewers to verify duty cycle changes in response to button inputs.
#### Hardware Testing
- Connect the FPGA outputs to an oscilloscope to observe the PWM waveform.
= Press the buttons to verify duty cycle adjustments.

---

## Credits and References
This project is developed as part of the CEG Fabless initiative by Team CF-2024-TT10-05. For a complete list of contributors, mentors, and research references, please see [CREDITS.md](./CREDITS.md).

