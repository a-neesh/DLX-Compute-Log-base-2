.global _exit
.global _printf
.global _a
        .align 4
_a:
        .word 13
LC0:
        .ascii "Log of 13 is %d\12\0"
        .align 4
.global _main
_main:
        add r14, r0, r0
        lhi r14, ((memSize-4)>>16)&0xffff
        addui r14, r14, ((memSize-4)&0xffff)
        lhi r4, (_a>>16)&0xffff
        addui r4, r4, (_a&0xffff)
        lw r4, 0(r4)

        ; if the number is power of 2, then r3 = -1, else r3=0
        sub r5, r4, #1
        and r5, r5, r4
        beqz r5, _r3_initialise
        nop
        add r3, r0, r0
        j _my_loop_in
        nop
_r3_initialise:
        sub r3, r0, #1

_my_loop_in:
        beqz r4, _my_loop_out
        nop
        srli r4, r4, #1
        add r3, r3, #1
        j _my_loop_in
        nop
_my_loop_out:
        sub r14, r14, #8
        lhi r5, (LC0>>16)&0xffff
        addui r5, r5, (LC0&0xffff)
        sw 0(r14), r5
        sw 4(r14), r3
        jal _printf
        nop
        add r14, r14, #8
        jal _exit
        nop
_exit:
        trap #0
        jr r31
        nop
_printf:
        trap #5
        jr r31
        nop