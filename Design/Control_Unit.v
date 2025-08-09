module Control_Unit(Op_Code,Reg_Dst,Jump,Branch,Mem_Read,Mem_To_Reg,ALU_OP,Mem_Write,ALU_Src,Reg_Write,Branch_Not_Equal,return_addr,data_size,ext_type);

input [5:0] Op_Code;
output  Reg_Dst,ALU_Src,Mem_To_Reg,Reg_Write,Mem_Read,Mem_Write,Branch,Jump,Branch_Not_Equal,return_addr,ext_type;
output [1:0] data_size;
output [2:0] ALU_OP;
reg [15:0] temp;
always @(*) begin
        case (Op_Code)
            6'b000000: temp = 16'b1001000000100001; // R-Format 
            6'b100011: temp = 16'b0111100000000111; // LW   
            6'b101011: temp = 16'b0100010000000111; // SW   
            6'b000100: temp = 16'b0000001000010001; // BEQ
            6'b000101: temp = 16'b0000000010010001; // BNE
            6'b001000: temp = 16'b0101000000000001; // ADDI
            6'b001100: temp = 16'b0101000000110000; // ANDI
            6'b001101: temp = 16'b0101000001000000; // ORI
            6'b001010: temp = 16'b0101000001010001; // SLTI
            6'b001111: temp = 16'b0101000001100000; // LUI
            6'b001110: temp = 16'b0101000001110000; // XORI
            6'b000010: temp = 16'b0000000100000001; // J
            6'b000011: temp = 16'b0001000100001001; // JAL
            6'b100000: temp = 16'b0111100000000011; // LB   
            6'b100001: temp = 16'b0111100000000101; // LH   
            6'b101000: temp = 16'b0100010000000011; // SB   
            6'b101001: temp = 16'b0100010000000101; // SH   
            default:   temp = 16'b0000000000000000; 
        endcase
    end

    assign {Reg_Dst, ALU_Src, Mem_To_Reg, Reg_Write,
            Mem_Read, Mem_Write, Branch, Jump,
            Branch_Not_Equal, ALU_OP,return_addr,data_size,ext_type} = temp;
endmodule