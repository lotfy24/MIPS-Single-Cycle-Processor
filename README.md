# 🚀 Single-Cycle MIPS Processor

## 📚 Project Overview

This repository contains the RTL design and testbench for a **Single-Cycle MIPS Processor** implemented in Verilog. The design supports a comprehensive subset of MIPS instructions covering R-type, I-type, and J-type formats. The processor executes instructions in a single clock cycle and includes instruction memory, data memory, register file, ALU, and control logic.

---

## 🛠️ Features

- Supports major MIPS instructions including arithmetic, logic, load/store, branches, and jumps
- Fully combinational ALU with control signals
- Program Counter and branching logic with jump handling
- Instruction and data memories modeled with parameterizable sizes
- Register file with synchronous write and asynchronous read
- Testbench with automatic checking of instruction correctness and program counter
- Big Endian memory layout

---

## 📁 Repository Structure

├── Design/ # RTL source files
│ ├── ALU_Control.v
│ ├── ALU.v
│ ├── Branch_Block.v
│ ├── Control_Unit.v
│ ├── Data_Memory.v
│ ├── Extention.v
│ ├── instruction_mem.v
│ ├── Jump_Block.v
│ ├── Main_ALU.v
│ ├── MIPS.v
│ ├── mux_2_1.v
│ ├── PC_Adder.v
│ ├── Program_Counter.v
│ └── Register_File.v
├── Test_Bench/ # Testbench files and memory initialization files
│ ├── MIPS_Processor_tb.v
│ ├── Imem.dat
│ ├── Dmem.dat
│ └── register_file.dat
└── MIPS_Processor.do # Simulation script for ModelSim/Questa or similar

yaml
Copy
Edit

---

## 📖 Supported Instructions

| Instruction | Type   | Opcode  |
|-------------|--------|---------|
| ADD         | R-type | 000000  |
| SUB         | R-type | 000000  |
| AND         | R-type | 000000  |
| OR          | R-type | 000000  |
| NOR         | R-type | 000000  |
| XOR         | R-type | 000000  |
| SLL         | R-type | 000000  |
| SRL         | R-type | 000000  |
| SRA         | R-type | 000000  |
| SLT         | R-type | 000000  |
| ADDI        | I-type | 001000  |
| ANDI        | I-type | 001100  |
| ORI         | I-type | 001101  |
| XORI        | I-type | 001110  |
| SLTI        | I-type | 001010  |
| LUI         | I-type | 001111  |
| LW          | I-type | 100011  |
| SW          | I-type | 101011  |
| LB          | I-type | 100000  |
| LH          | I-type | 100001  |
| SB          | I-type | 101000  |
| SH          | I-type | 101001  |
| BEQ         | I-type | 000100  |
| BNE         | I-type | 000101  |
| J           | J-type | 000010  |
| JAL         | J-type | 000011  |

---

## ⚙️ Getting Started

### Requirements

- Verilog simulator (ModelSim, Questa, Vivado Simulator, etc.)
- Basic understanding of MIPS ISA and Verilog

### How to Simulate

1. Load the design files and testbench into your simulator.
2. Load the memory initialization files (`Imem.dat`, `Dmem.dat`, and `register_file.dat`).
3. Run the provided `MIPS_Processor.do` simulation script (for ModelSim/Questa).
4. Observe the simulation outputs and verify correctness.

---

## 🧪 Testbench

The testbench (`MIPS_Processor_tb.v`) initializes memories, drives the clock and reset, and runs through the instruction memory. It checks the output of each instruction against expected values, including register contents and program counter updates. The testbench supports verification of:

- Arithmetic and logic operations
- Load and store instructions
- Branching and jumping behavior
- Memory access with different data sizes (byte, half-word, word)

---

## 📫 Contact

For any questions or contributions, please contact:

**Mohamed Lotfy**  
Email: lotfy24@example.com

---

Thank you for exploring this Single-Cycle MIPS Processor! Feel free to fork and improve it. 🚀
