# Parallel-In Serial-Out (PISO) Shift Register in Verilog

This repository contains a synchronous 8-bit **Parallel-In Serial-Out (PISO)** shift register. This component is essential for serial communication protocols where data is collected in parallel (8 bits at once) and transmitted over a single wire (1 bit at a time).

---

##  Overview

The PISO module converts an 8-bit parallel input vector into a serial stream. It is commonly used in UART transmitters, SPI interfaces, and to reduce the number of pins required for data transmission across long distances on a PCB.



---

##  How It Works

The module utilizes a shift register with dual functionality: **Loading** and **Shifting**.

### 1. Operation Modes
* **Reset (`rst`):** Asynchronously clears the internal register to `0`.
* **Load (`load`):** When high, the 8-bit input data `in[7:0]` is latched into the internal `shift_reg` on the next clock edge.
* **Shift (Default):** When `load` is low, the register performs a left-shift operation. The MSB (Most Significant Bit) is shifted out, and a `0` is shifted into the LSB (Least Significant Bit).

### 2. Implementation Logic
The shifting logic is implemented using the concatenation operator:
`shift_reg <= {shift_reg[6:0], 1'b0};`

The output `out` always tracks the MSB (`shift_reg[7]`), allowing the data to be read serially one bit per clock cycle.

---

##  Simulation & Testing

The testbench (`piso_tb`) verifies the logic through several phases:
1.  **Initialization:** Sets up the clock and applies an initial reset.
2.  **Parallel Load:** Loads the value `10110001` into the register.
3.  **Serial Shifting:** Disables `load` to allow the bits to stream out.
4.  **Mid-operation Reset:** Tests system robustness by triggering a reset during a shift sequence.
5.  **Secondary Load:** Demonstrates reloading a new pattern (`10101010`).

### Waveform Analysis
In a waveform viewer like GTKWave, you will see the `out` signal change every clock cycle to match the bits of the loaded `in` vector, starting from the MSB.

---

##  Usage

To use this module in your design, instantiate it as follows:

```verilog
piso u_piso (
    .clk(clk),      // System Clock
    .rst(rst),      // Active High Reset
    .load(load),    // Load enable (High = Load, Low = Shift)
    .in(data_8bit), // 8-bit parallel data input
    .out(serial_tx) // Serial data output
);
