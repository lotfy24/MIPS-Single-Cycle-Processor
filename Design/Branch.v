module Branch_Block(PC_Plus_4,sign_Ext_out,Z_Flag,Branch,Branch_Not_Equal,out);
input [31:0] PC_Plus_4,sign_Ext_out;
input Z_Flag,Branch,Branch_Not_Equal;
output [31:0] out;

wire [31:0] shift_out, ALU_Result;
wire PCSrc,beq_out,bne_out;

assign shift_out = sign_Ext_out << 2;   
assign ALU_Result = shift_out + PC_Plus_4;
assign beq_out = Branch & Z_Flag;               // for BEQ instruction
assign bne_out = Branch_Not_Equal & (~Z_Flag) ; // for BNE instruction
assign PCSrc   = beq_out | bne_out;
assign out = (PCSrc == 1)?ALU_Result : PC_Plus_4;

endmodule