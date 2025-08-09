module Extention(in,ext_type,out);
input ext_type; // sign Extention (1) and Zero Extention (0)
input [15:0] in;
output [31:0] out;
assign out = (ext_type==1)?{{16{in[15]}},in}:{16'b0,in};
endmodule   