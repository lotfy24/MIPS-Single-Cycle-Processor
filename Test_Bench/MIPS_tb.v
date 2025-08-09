module MIPS_Prossesor_tb();
    reg clk_tb, rst_n_tb;
    reg [15:0] immediate_address;
    reg [25:0] Jumb_address;
    reg [31:0] expected_output, expected_PC, addr, instruction;
    reg [4:0] rs, rt, rd, shamt;
    reg [5:0] funct, op;
    MIPS DUT(clk_tb, rst_n_tb);
    integer i;

    initial begin
        clk_tb = 0;
        forever #1 clk_tb = ~clk_tb;
    end

    initial begin
        $readmemb("Imem.dat", DUT.inst_mem_Block.inst_mem);
        $readmemb("Dmem.dat", DUT.Data_mem_Block.data_mem);
        $readmemh("register_file.dat", DUT.Reg_File_Block.reg_file);
        rst_n_tb = 0;
        expected_PC = 0;
        op = 0;
        rs = 0;
        rt = 0;
        addr = 0;
        shamt = 0;
        funct = 0;
        immediate_address = 0;
        Jumb_address = 0;
        @(negedge clk_tb);
        rst_n_tb = 1;

        for (i = 0; i < 100; i = i + 1) begin
            // Load Instructions from instructiom mem 
            instruction[7:0]   = DUT.inst_mem_Block.inst_mem[expected_PC + 3];
            instruction[15:8]  = DUT.inst_mem_Block.inst_mem[expected_PC + 2];
            instruction[23:16] = DUT.inst_mem_Block.inst_mem[expected_PC + 1];
            instruction[31:24] = DUT.inst_mem_Block.inst_mem[expected_PC];
            // Assign 32 bits of R,I and J types 
            op = instruction[31:26];
            rs = instruction[25:21];
            rt = instruction[20:16];
            immediate_address = instruction[15:0];
            Jumb_address = instruction[25:0];

            if (op == 6'b000_000) begin  // R Format
                rd = instruction[15:11];
                shamt = instruction[10:6];
                funct = instruction[5:0];
            end else begin  // I and jump Formats
                rd = 5'b0;
                shamt = 5'b0;
                funct = 6'b0;
            end
            case (op)
                6'b000_000: begin // R-type
                    case (funct)
                        6'b100_000: begin // ADD
                            expected_output = DUT.Reg_File_Block.reg_file[rs] +DUT.Reg_File_Block.reg_file[rt];
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in ADD instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b100_010: begin // SUB
                            expected_output = DUT.Reg_File_Block.reg_file[rs] - DUT.Reg_File_Block.reg_file[rt];
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in SUB instruction");
                                $stop;
                            end
                             if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b100_100: begin // AND
                            expected_output = DUT.Reg_File_Block.reg_file[rs] & DUT.Reg_File_Block.reg_file[rt];
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in AND instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b100_101: begin // OR
                            expected_output = DUT.Reg_File_Block.reg_file[rs] | DUT.Reg_File_Block.reg_file[rt];
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in OR instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b100_111: begin // NOR
                            expected_output = ~(DUT.Reg_File_Block.reg_file[rs] | DUT.Reg_File_Block.reg_file[rt]);
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in NOR instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                         6'b100_110:begin    //XOR
                            expected_output = DUT.Reg_File_Block.reg_file[rs] ^ DUT.Reg_File_Block.reg_file[rt];
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in XOR instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b000_000: begin // SLL
                            expected_output = DUT.Reg_File_Block.reg_file[rt] << shamt;
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in SLL instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b101_010: begin // SLT
                            expected_output = ($signed(DUT.Reg_File_Block.reg_file[rs]) < $signed(DUT.Reg_File_Block.reg_file[rt])) ? 32'b1 : 32'b0;
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in SLT instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b000_011: begin // SRA
                            expected_output = $signed(DUT.Reg_File_Block.reg_file[rt]) >>> shamt;
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rd])) begin
                                $display("Error in SRA instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        6'b000_010: begin // SRL
                            expected_output = DUT.Reg_File_Block.reg_file[rt] >> shamt;
                            expected_PC = expected_PC + 4;
                            @(negedge clk_tb);
                            if (expected_output != DUT.Reg_File_Block.reg_file[rd]) begin
                                $display("Error in SRL instruction");
                                $stop;
                            end
                            if(expected_PC != DUT.PC_Block.PC_next )begin
                                $display("Mismatch in program counter");
                                $stop;
                            end
                        end
                        default: begin
                            expected_output = 32'b0 ;
                            $display("Unsuported R type instruction");
                            $stop;
                        end
                    endcase
                end
                6'b001_000: begin // ADDI
                    expected_output = $signed(DUT.Reg_File_Block.reg_file[rs]) + $signed(immediate_address);
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                    if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rt])) begin
                        $display("Error in ADDI instruction");
                        $stop;
                    end
                   if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b001_100: begin // ANDI
                    expected_output = DUT.Reg_File_Block.reg_file[rs] & {16'b0, immediate_address};
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                    if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rt])) begin
                        $display("Error in ANDI instruction");
                        $stop;
                    end
                   if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b001_101: begin // ORI
                    expected_output = DUT.Reg_File_Block.reg_file[rs] | {16'b0, immediate_address};
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                    if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rt])) begin
                        $display("Error in ORI instruction");
                        $stop;
                    end
                   if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b001_110:begin    //XORI
                    expected_output = DUT.Reg_File_Block.reg_file[rs] ^ {16'b0, immediate_address};
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                    if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rt])) begin
                        $display("Error in ORI instruction");
                        $stop;
                    end
                   if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b001_010: begin // SLTI
                    expected_output = ($signed(DUT.Reg_File_Block.reg_file[rs]) < $signed(immediate_address)) ? 32'b1 : 32'b0;
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                    if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rt])) begin
                        $display("Error in SLTI instruction");
                        $stop;
                    end
                   if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b001_111: begin // LUI
                    expected_output = {immediate_address, 16'b0};
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                    if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rt])) begin
                        $display("Error in LUI instruction");
                        $stop;
                    end
                   if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b100_011: begin // LW
                    addr = DUT.Reg_File_Block.reg_file[rs] + $signed(immediate_address);
                    expected_output[31:24] = DUT.Data_mem_Block.data_mem[addr];     
                    expected_output[23:16] = DUT.Data_mem_Block.data_mem[addr + 1];
                    expected_output[15:8]  = DUT.Data_mem_Block.data_mem[addr + 2];
                    expected_output[7:0]   = DUT.Data_mem_Block.data_mem[addr + 3]; 
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                    if (expected_output != $signed(DUT.Reg_File_Block.reg_file[rt])) begin
                        $display("Error in LW instruction");
                        $stop;
                    end
                    if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b101_011: begin // SW
                    addr = DUT.Reg_File_Block.reg_file[rs] + $signed(immediate_address);
                    expected_output = DUT.Reg_File_Block.reg_file[rt];
                    expected_PC = expected_PC + 4;
                    @(negedge clk_tb);
                     if (expected_output != {DUT.Data_mem_Block.data_mem[addr], 
                                             DUT.Data_mem_Block.data_mem[addr + 1],
                                             DUT.Data_mem_Block.data_mem[addr + 2],
                                             DUT.Data_mem_Block.data_mem[addr + 3]}) begin
                        $display("Error in SW instruction");
                        $stop;
                    end
                    if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter");
                        $stop;
                    end
                end
                6'b000_100: begin // BEQ
                    if (DUT.Z_Flag) begin
                        expected_PC = expected_PC + 4 + ($signed(immediate_address)<<2);
                    end else begin
                        expected_PC = expected_PC + 4;
                    end
                    @(negedge clk_tb);
                    if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter at BEQ instruction");
                        $stop;
                    end
                end
                6'b000_101: begin // BNE
                    if (~(DUT.Z_Flag)) begin
                         expected_PC = expected_PC + 4 + ($signed(immediate_address)<< 2);
                    end else begin
                        expected_PC = expected_PC + 4;
                    end
                    @(negedge clk_tb);
                    if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter at BNE instruction");
                        $stop;
                    end
                end
                6'b000_010:begin    //J
                    expected_PC = {expected_PC[31:28], Jumb_address, 2'b00};
                    @(negedge clk_tb);
                    if(expected_PC != DUT.PC_Block.PC_next )begin
                        $display("Mismatch in program counter at J instruction");
                        $stop;
                    end
                end
                6'b000_011: begin // JAL
                    expected_output = expected_PC + 4; 
                    expected_PC = {expected_PC[31:28], Jumb_address, 2'b00};
                    @(negedge clk_tb);
                    if (expected_PC != DUT.PC_Block.PC_next) begin
                        $display("Mismatch in program counter at JAL instruction");
                        $stop;
                    end
                end
                6'b100_000:begin    //LB
                    addr = DUT.Reg_File_Block.reg_file[rs] + $signed(immediate_address);
                    expected_output[31:8] = {24{DUT.Data_mem_Block.data_mem[addr][7]}};  
                    expected_output[7:0]  = DUT.Data_mem_Block.data_mem[addr];           
                    expected_PC = expected_PC + 4; 
                    @(negedge clk_tb);
                    if(expected_output !=  $signed(DUT.Reg_File_Block.reg_file[rt]))begin
                        $display("Error in LB instruction");
                        $stop;
                    end
                    if (expected_PC != DUT.PC_Block.PC_next) begin
                        $display("Mismatch in program counter at LB instruction");
                        $stop;
                    end
                end
                6'b100_001:begin    //LH
                    addr = DUT.Reg_File_Block.reg_file[rs] + $signed(immediate_address);
                    expected_output[31:16] = {16{DUT.Data_mem_Block.data_mem[addr][7]}};
                    expected_output[15:8]  = DUT.Data_mem_Block.data_mem[addr];
                    expected_output[7:0]   =DUT.Data_mem_Block.data_mem[addr + 1]; 
                    expected_PC = expected_PC + 4; 
                    @(negedge clk_tb);
                    if(expected_output !=  $signed(DUT.Reg_File_Block.reg_file[rt]))begin
                        $display("Error in LH instruction");
                        $stop;
                    end
                    if (expected_PC != DUT.PC_Block.PC_next) begin
                        $display("Mismatch in program counter at LH instruction");
                        $stop;
                    end
                end
                6'b101_000:begin    //SB
                   addr = DUT.Reg_File_Block.reg_file[rs] + $signed(immediate_address);
                   expected_output = DUT.Reg_File_Block.reg_file[rt][7:0];
                   expected_PC = expected_PC + 4; 
                     if(DUT.Data_mem_Block.data_mem[addr[7:0]] != expected_output)begin
                        $display("Error in SB instruction");
                        $stop;
                    end
                    @(negedge clk_tb);
                    if (expected_PC != DUT.PC_Block.PC_next) begin
                        $display("Mismatch in program counter at SB instruction");
                        $stop;
                    end
                end
                6'b101_001:begin    //SH
                   addr = DUT.Reg_File_Block.reg_file[rs] + $signed(immediate_address);
                   expected_output = DUT.Reg_File_Block.reg_file[rt][15:0];
                   expected_PC = expected_PC + 4;
                   @(negedge clk_tb); 
                   if (DUT.Data_mem_Block.data_mem[addr[7:0]] !== expected_output[15:8] ||
                       DUT.Data_mem_Block.data_mem[addr[7:0]+1] !== expected_output[7:0])begin
                        $display("Error in SH instruction");
                        $stop;
                    end
                    if (expected_PC != DUT.PC_Block.PC_next) begin
                        $display("Mismatch in program counter at SH instruction");
                        $stop;
                    end
                end
                default: begin
                    $display("Error: Unsupported opcode=%b",op);
                    $stop;
                end
            endcase
        end
        $display("Simulation completed successfully");
        $stop;
end
initial begin
    $monitor("op=%b, rs=%b, rt=%b, rd=%b, funct=%b, imm=%d, expected_PC=%d, actual_PC=%d, expected_output=%d", 
                      op, rs, rt, rd, funct, immediate_address, expected_PC, DUT.PC_Block.PC_next, expected_output);
end
endmodule