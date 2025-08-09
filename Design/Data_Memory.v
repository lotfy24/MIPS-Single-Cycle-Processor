module Data_Memory(Address,clk,wr_data,Mem_Write,Mem_Read,data_size,rd_Data);
parameter Width = 8;
parameter Depth = 1024;

input [31:0] Address, wr_data;
input [1:0] data_size;
input clk,Mem_Write, Mem_Read;
output reg [31:0] rd_Data;

reg [Width-1:0] data_mem [Depth-1:0];
// Big Endian
always @(*) begin
    // Read Operation
    if (Mem_Read) begin
        case (data_size)    
            2'b01:begin     // Byte load
               rd_Data[31:8] = {24{data_mem[Address][7]}};  
               rd_Data[7:0]  = data_mem[Address];                        
            end
            2'b10:begin     // Half Word Load
               rd_Data[31:16] = {16{data_mem[Address][7]}};
               rd_Data[15:8]  = data_mem[Address];
               rd_Data[7:0]   = data_mem[Address + 1]; 
            end
            default:begin    // Word Load
               rd_Data[31:24] = data_mem[Address]; // MSB
               rd_Data[23:16] = data_mem[Address + 1];
               rd_Data[15:8]  = data_mem[Address + 2];
               rd_Data[7:0]   =data_mem[Address + 3]; // LSB
            end    
        endcase
    end
    else begin
        rd_Data = 32'b0 ;   // To avoid latch 
    end
end
// Write Operation
always @(posedge clk) begin   
    if (Mem_Write) begin    
        case (data_size)
            2'b01:begin
                data_mem[Address] <= wr_data[7:0];   // Byte Store
            end
            2'b10:begin    // Half Word Store
                data_mem[Address] <= wr_data[15:8];
                data_mem[Address +1] <= wr_data[7:0];
            end
            default:begin    // Word Store
               data_mem[Address]     <= wr_data[31:24]; // MSB
               data_mem[Address + 1] <= wr_data[23:16];
               data_mem[Address + 2] <= wr_data[15:8];
               data_mem[Address + 3] <= wr_data[7:0];   // LSBB
            end    
        endcase
    end
end  
endmodule