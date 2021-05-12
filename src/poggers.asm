.macro push reg
	addi $sp, $sp, -4
	sw \reg, 0($sp)
.endm

.macro pop reg
	lw \reg, 0($sp)
	addi $sp, $sp, 4
.endm

.macro br_arg_eq_to str jmp_to
	move $a1, $s0
	la $a0, \str
	jal strcomp
	beqz $v0, \jmp_to
.endm

.macro print str len
	li $a0, 1
	la $a1, \str
	li $a2, \len
	li $v0, 4004
	syscall
.endm

.macro print_art art artn
	li $a0, 1
	la $a1, \art
	la $a2, \artn
	lw $a2, 0($a2)
	li $v0, 4004
	syscall
	j exit
.endm


.data
argnmsg:	.asciiz "Insert no more than one argument.\n"
argmsg:		.asciiz "Unrecognised argument.\n"
help:	.asciiz "goPoggers: celebrate something with the right energy.\n\nUSAGE: ./poggers [ [-a | -b | -p] | [-h | --help] ]\n\nOPTIONS:\n\t-h | --help\tshow this help\n\t-p\t\tpixel style (default)\n\t-a\t\tascii style\n\t-b\t\tblock style\n"
p:		.asciiz "-p"
a:		.asciiz "-a"
b:		.asciiz "-b"
h:		.asciiz "-h"
hh:		.asciiz "--help"


.text
.globl __start
__start:
	li $t0, 2
	pop $t1
	bgt $t1, $t0, errargn
	li $t0, 1
	beq $t1, $t0, ppixel

	lw $s0, 4($sp)
	addi $sp, $sp, 8

	br_arg_eq_to p ppixel
	br_arg_eq_to a pascii
	br_arg_eq_to b pblock
	br_arg_eq_to h phelp
	br_arg_eq_to hh phelp
	j errarg

ppixel:
	print_art pixel pixeln

pascii:
	print_art ascii asciin

pblock:
	print_art block blockn

errarg:
	print argmsg 23
	j phelp

errargn:
	print argnmsg 34

phelp:
	print help 205

exit:
	li $v0, 4001
	li $a0, 0
	syscall
