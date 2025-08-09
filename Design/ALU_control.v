module ALU_Control(ALU_OP_D,Funct,ALU_Instruction);
input [2:0] ALU_OP_D;
input [5:0] Funct;
output reg [3:0] ALU_Instruction;

always @(*) begin
    case (ALU_OP_D)
        3'b000: ALU_Instruction = 4'b0010; // ADD for LW/SW instructions
        3'b001: ALU_Instruction = 4'b0110; // SUB for beq/bne instructions
        3'b010: begin
            case (Funct)
                6'b100_000: ALU_Instruction = 4'b0010; //ADD (2)
                6'b100_010: ALU_Instruction = 4'b0110; //SUB (6)
                6'b100_100: ALU_Instruction = 4'b0000; //AND (0)
                6'b100_101: ALU_Instruction = 4'b0001; //OR  (1)
                6'b100_111: ALU_Instruction = 4'b1100; //NOR (12)
                6'b100_110: ALU_Instruction = 4'b1101; //XOR (13)
                6'b000_000: ALU_Instruction = 4'b0100; //SLL (4)
                6'b101_010: ALU_Instruction = 4'b0111; //SLT (7)
                6'b000_011: ALU_Instruction = 4'b0101; //SRA (5)
                6'b000_010: ALU_Instruction = 4'b1000; //SRL (8)
                default: ALU_Instruction = 4'b1111;    //UNSupported Instruction
            endcase
        end
        3'b011: ALU_Instruction = 4'b0000; //ANDI (0)
        3'b100: ALU_Instruction = 4'b0001; //ORI (1)
        3'b101: ALU_Instruction = 4'b0111; //SLTI (7)
        3'b110: ALU_Instruction = 4'b1001; //LUI (9)
        3'b111: ALU_Instruction = 4'b1101; //XORI (13)
    endcase
end
endmodule
