module Program_Counter (PC_current,clk,rst_n,PC_next);
input clk , rst_n;
input [31:0] PC_current;
output reg  [31:0] PC_next ;

always @(posedge clk , negedge rst_n) begin
    if(~ rst_n)begin
      PC_next <=0;
    end
    else
        PC_next <= PC_current;
end

endmodule