module mux_2_1 (a,b,sel,out);
parameter n = 32;
input [n-1 :0] a,b;
input sel;
output [n-1 :0] out;

assign out = (sel == 1)? b:a;

endmodule