module PC_Adder (PC_next ,PC_Plus_4);
input [31:0] PC_next;
output [31:0] PC_Plus_4;

assign PC_Plus_4 = PC_next + 4 ;

endmodule