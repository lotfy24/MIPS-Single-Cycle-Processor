module Jump_Block(instruction_25_0,PC_Plus_4,branch_out,Jump,out);
input [25:0] instruction_25_0;
input [3:0] PC_Plus_4;
input [31:0] branch_out;
input Jump;
output [31:0] out;

wire [27:0] shift_out;
wire [31:0] Jump_Address;

assign shift_out = instruction_25_0 << 2;
assign Jump_Address = {PC_Plus_4,shift_out};
assign out = (Jump == 1)? Jump_Address : branch_out;

endmodule