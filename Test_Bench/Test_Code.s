sb   $t0, 0($s0)          
sh   $t1, 2($s0)          
lb   $s1, 0($s0)         
lh   $s2, 2($s0)          
lui  $s0, 0x8000          
ori  $s0, $s0, 0x0000     
sw   $t0, 0($s0)          
sw   $t1, 4($s0)
sw   $t2, 8($s0)
lw   $s1, 0($s0)         
lw   $s2, 4($s0)
lw   $s3, 8($s0)
addi $t0, $zero, 5        
addi $t1, $zero, 10       
andi $t2, $t1, 0x000F     
ori  $t3, $t2, 0x000F     
slti $t4, $t3, 50        
lui  $t5, 0x1234          
xori $t6, $t5, 0x00FF     
add  $t6, $t0, $t1        
sub  $t7, $t1, $t0       
and  $t8, $t6, $t7       
or   $t9, $t6, $t7       
xor  $s0, $t7, $t2        
nor  $s1, $t0, $t1       
sll  $s2, $t0, 2          
sra  $s3, $t1, 1          
srl  $s4, $t1, 1          
slt  $t0, $t0, $t1       
beq  $t0, $t0, +2         
addi $v0, $zero, 4
addi $v0, $zero, 10
jal  0x1F                 
bne  $t0, $zero, -2       
j    0x78                 
addi $t5, $zero, 42       
j    0x14                 
