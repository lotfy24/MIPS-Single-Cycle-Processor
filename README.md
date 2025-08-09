# 🚀 Single-Cycle MIPS Processor

<img width="1199" height="679" alt="image" src="https://github.com/user-attachments/assets/0ecb3c32-5f18-4322-ab07-93d6446bdfd8" />
This single-cycle MIPS processor is designed based on the classic MIPS instruction set architecture, similar to the reference diagram commonly taught in Computer Organization courses,my implementation supports a much broader set of instructions beyond those shown in the picture
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

| Path | Description |
|------|-------------|
| **Design/ALU_Control.v** | ALU control logic module |
| **Design/ALU.v** | Arithmetic Logic Unit implementation |
| **Design/Branch_Block.v** | Branch decision logic |
| **Design/Control_Unit.v** | Main control unit for instruction decoding |
| **Design/Data_Memory.v** | Data memory module |
| **Design/Extention.v** | Sign/zero extension unit |
| **Design/instruction_mem.v** | Instruction memory module |
| **Design/Jump_Block.v** | Jump instruction handling logic |
| **Design/Main_ALU.v** | Main ALU integrating operations |
| **Design/MIPS.v** | Top-level MIPS processor module |
| **Design/mux_2_1.v** | 2-to-1 multiplexer |
| **Design/PC_Adder.v** | Program counter incrementer |
| **Design/Program_Counter.v** | Program counter register |
| **Design/Register_File.v** | CPU register file |
| **Test_Bench/MIPS_Processor_tb.v** | Testbench for the MIPS processor |
| **Test_Bench/Imem.dat** | Instruction memory initialization data |
| **Test_Bench/Dmem.dat** | Data memory initialization data |
| **Test_Bench/register_file.dat** | Register file initialization data |
| **MIPS_Processor.do** | Simulation script for ModelSim/Questa |

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
Email: mohamedlotfyyy24@gmail.com
