vlib work
vlog ALU_control.v Branch.v  Control_Unit.v Data_Memory.v  Instruction_mem.v Jump.v Main_ALU.v MIPS_Prosessor.v MIPS_tb.v MUX_2_1.v PC_adder.v Program_Counter.v Register_File.v Sighn_Extention.v
vsim -voptargs=+acc work.MIPS_Prossesor_tb
add wave *
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/Data_mem_Block/data_mem
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/Reg_File_Block/reg_file
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/PC_Block/PC_next
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/Reg_File_Block/rd_data_1 \
sim:/MIPS_Prossesor_tb/DUT/Reg_File_Block/rd_data_2 \
sim:/MIPS_Prossesor_tb/DUT/Reg_File_Block/rd_register_1 \
sim:/MIPS_Prossesor_tb/DUT/Reg_File_Block/rd_register_2
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/Reg_File_Block/wr_data \
sim:/MIPS_Prossesor_tb/DUT/Reg_File_Block/wr_register
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/Data_mem_Block/rd_Data
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/Data_mem_Block/wr_data
add wave -position insertpoint  \
sim:/MIPS_Prossesor_tb/DUT/Data_mem_Block/Address

run -all
//quit -sim
