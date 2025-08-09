module MIPS(clk, rst_n);
// Inputs
(* dont_touch = "true" *)  input clk, rst_n;

// Internal Wires ((* dont_touch = "true" *)) for vivado to prevent it from optimization
(* dont_touch = "true" *)  wire [31:0] Instruction, PC_IN, write_data, PC_next, ALU_Result, Read_Data;
(* dont_touch = "true" *)  wire [31:0] PC_Plus_4, Read_Data_1, Read_Data_2, Ex_out, Main_ALU_in_2, Branch_out;
(* dont_touch = "true" *)  wire [4:0] Write_Reg;
(* dont_touch = "true" *)  wire [2:0] ALU_OP;
(* dont_touch = "true" *)  wire [1:0] data_size;
(* dont_touch = "true" *)  wire [3:0] ALU_control_Lines;
(* dont_touch = "true" *)  wire Reg_Dst,Jump,Branch,Mem_Read,Mem_To_Reg,Mem_Write,ALU_Src;
(* dont_touch = "true" *)  wire Reg_Write,Branch_Not_Equal,Z_Flag,return_addr,ext_type;

// Control unit
Control_Unit Ctr_Block(Instruction[31:26],Reg_Dst,Jump,Branch,Mem_Read,Mem_To_Reg,ALU_OP,Mem_Write,ALU_Src,Reg_Write,Branch_Not_Equal,return_addr,data_size,ext_type);

ALU_Control ALU_Ctr_Block(ALU_OP,Instruction[5:0],ALU_control_Lines);

// Program Counter
Program_Counter PC_Block(PC_IN,clk,rst_n,PC_next);

// PC + 4 Adder
PC_Adder PC_ALU(PC_next,PC_Plus_4);

// Instruction Memory
instruction_mem inst_mem_Block(PC_next,Instruction);

// Destination Register MUX
mux_2_1 #(5) Dst_Mux(Instruction[20:16],Instruction[15:11],Reg_Dst,Write_Reg);

// Register File
Register_File Reg_File_Block(Instruction[25:21],Instruction[20:16],Write_Reg,write_data,Reg_Write,return_addr,PC_next,clk,Read_Data_1,Read_Data_2);

// sign and zero Extention
Extention EX_Block(Instruction[15:0],ext_type,Ex_out);

// ALU Source MUX
mux_2_1 ALUSrc_Mux(Read_Data_2,Ex_out,ALU_Src,Main_ALU_in_2);

// ALU
Main_ALU ALU_Block(Read_Data_1,Main_ALU_in_2,Instruction[10:6],ALU_control_Lines,Z_Flag,ALU_Result);

// Data Memory
Data_Memory Data_mem_Block(ALU_Result,clk,Read_Data_2,Mem_Write,Mem_Read,data_size,Read_Data);

// Memory to Register MUX
mux_2_1 mem_to_reg_mux(ALU_Result,Read_Data,Mem_To_Reg,write_data);

// Branch Target
Branch_Block B(PC_Plus_4,Ex_out,Z_Flag,Branch,Branch_Not_Equal,Branch_out);

// Jump Target
Jump_Block J(Instruction[25:0],PC_Plus_4[31:28],Branch_out,Jump,PC_IN);

endmodule
