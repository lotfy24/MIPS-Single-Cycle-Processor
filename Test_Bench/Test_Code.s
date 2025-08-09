sb   $t0, 0($s0)          # Store byte
sh   $t1, 2($s0)          # Store halfword
lb   $s1, 0($s0)          # Load byte
lh   $s2, 2($s0)          # Load halfword
lui  $s0, 0x8000          # Load upper immediate
ori  $s0, $s0, 0x0000     # Complete base addr = 0x80000000
sw   $t0, 0($s0)          # Store word
sw   $t1, 4($s0)
sw   $t2, 8($s0)
lw   $s1, 0($s0)          # Load word
lw   $s2, 4($s0)
lw   $s3, 8($s0)
addi $t0, $zero, 5        # t0 = 5
addi $t1, $zero, 10       # t1 = 10
andi $t2, $t1, 0x000F     # t2 = t1 & 0x000F
ori  $t3, $t2, 0x000F     # t3 = t2 | 0x000F
slti $t4, $t3, 50         # t4 = (t3 < 50)
lui  $t5, 0x1234          # t5 = 0x12340000
xori $t6, $t5, 0x00FF     # t6 = t5 ^ 0x00FF
add  $t6, $t0, $t1        # t6 = t0 + t1
sub  $t7, $t1, $t0        # t7 = t1 - t0
and  $t8, $t6, $t7        # t8 = t6 & t7
or   $t9, $t6, $t7        # t9 = t6 | t7
xor  $s0, $t7, $t2        # s0 = t7 ^ t2
nor  $s1, $t0, $t1        # s1 = ~(t0 | t1)
sll  $s2, $t0, 2          # s2 = t0 << 2
sra  $s3, $t1, 1          # s3 = t1 >> 1 (arith)
srl  $s4, $t1, 1          # s4 = t1 >> 1 (logic)
slt  $t0, $t0, $t1        # t0 = (t0 < t1)
beq  $t0, $t0, +2         # skip 2 instr
addi $v0, $zero, 4
addi $v0, $zero, 10
jal  0x1F                 # jump to 0x7C, save PC+4 in $ra
bne  $t0, $zero, -2       # loop back if t0 ≠ 0
j    0x78                 # jump to dummy subroutine
addi $t5, $zero, 42       # dummy subroutine body
j    0x14                 # return to instruction after jal (0x50)
