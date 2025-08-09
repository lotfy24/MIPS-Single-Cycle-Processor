 module Main_ALU(in1,in2,shamt,ALU_control_Lines,Z_Flag,Result);
input [31:0] in1,in2;
input [3:0] ALU_control_Lines;
input [4:0] shamt;
output reg Z_Flag;
output reg [31:0] Result;

always @(*) begin
     case(ALU_control_Lines)
        4'b0010: Result = in1 + in2;                                    //ADD (2)
        4'b0110: Result = in1 - in2;                                    //SUB (6)
        4'b0000: Result = in1 & in2;                                    //AND (0)
        4'b0001: Result = in1 | in2;                                    //OR  (1)
        4'b1100: Result = ~(in1 | in2);                                 //NOR (12)
        4'b0100: Result = in2 << shamt;                                 //SLL (4)
        4'b0111: Result = ($signed(in1) < $signed(in2))?32'b1:32'b0;    //SLT (7)
        4'b0101: Result = $signed(in2) >>> shamt;                       //SRA (5)
        4'b1000: Result = in2 >> shamt;                                 //SRL (8)
        4'b1001: Result = {in2[15:0], 16'b0};                           //LUI (9)
        4'b1101: Result = in1 ^ in2;                                    //XOR (13)
        default: Result = 32'b0;
    endcase
    Z_Flag = (Result==32'b0)? 1'b1 : 1'b0;
end
endmodule