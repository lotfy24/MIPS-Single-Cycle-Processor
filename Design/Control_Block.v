module Control(in_control_unit,in_ALU_Control,Reg_Dst,Jump,Branch,Mem_Read,Mem_To_Reg,ALU_OP,Mem_Write,ALU_Src,Reg_Write,Branch_Not_Equal,ext_type,ALU_control_Lines);
input [5:0] in_control_unit,in_ALU_Control;
output Reg_Dst,Jump,Branch,Mem_Read,Mem_To_Reg,Mem_Write,ALU_Src,Reg_Write,Branch_Not_Equal,ext_type;
output [2:0] ALU_OP;
output [3:0] ALU_control_Lines;
// instantations
Control_Unit Ctr_Block(in_control_unit,Reg_Dst,Jump,Branch,Mem_Read,Mem_To_Reg,ALU_OP,Mem_Write,ALU_Src,Reg_Write,Branch_Not_Equal,ext_type);
ALU_Control ALU_Ctr_Block(ALU_OP,in_ALU_Control,ALU_control_Lines);

endmodule