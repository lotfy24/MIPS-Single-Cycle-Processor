module Register_File (rd_register_1,rd_register_2,wr_register,wr_data,Reg_Write,return_addr,PC_next,clk,rd_data_1,rd_data_2);

parameter reg_width  = 32 ;
parameter reg_depth = 32 ;

input [4:0] rd_register_1,rd_register_2,wr_register;
input [31:0] wr_data,PC_next;
input Reg_Write ,return_addr,clk;
output  [31:0] rd_data_1,rd_data_2;

reg [reg_width-1 :0] reg_file [reg_depth-1 :0];

// Read Operation
assign rd_data_1 =  reg_file[rd_register_1];
assign rd_data_2 =  reg_file[rd_register_2]; 
// write Operation
always @(posedge clk) begin
     if(Reg_Write && (wr_register != 0))begin // Register is zero has a constant zero value so i can not override it with any value
        if(return_addr)begin
          reg_file[31] <= PC_next;
        end
        else 
        reg_file[wr_register] <= wr_data;
    end
end

endmodule