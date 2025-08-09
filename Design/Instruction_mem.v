module instruction_mem(rd_address, instruction);
parameter mem_width = 8 ;
parameter mem_depth = 1024;
input [31:0] rd_address;
output [31:0]  instruction;

reg [mem_width-1 :0] inst_mem [mem_depth-1 :0];

// BIG ENDIAN 

assign instruction[7:0]   = inst_mem[rd_address +3];    // LSB
assign instruction[15:8]  = inst_mem[rd_address +2];
assign instruction[23:16] = inst_mem[rd_address +1 ];
assign instruction[31:24] = inst_mem[rd_address];       // MSB
endmodule

