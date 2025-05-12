.syntax unified
.cpu cortex-m4
.thumb

.global vtable_kernel
.global __kernel_reset__

.section .interrupt_vector
vtable_kernel:
    .word __stack_start
    .word __kernel_reset__ + 1
.size vtable_kernel, .-vtable_kernel

.section .rodata
start_msg: .asciz "kernel started\n"
result_msg: .asciz "Result: "

.section .text
__kernel_reset__:
    ldr r0, =start_msg
    bl dbgput_line

    bl lab2

    ldr r0, =result_msg
    bl dbgput
    mov r0, r3
    bl dbgput_num

    b .

lab2:
    push {lr}
    mov r0, #8     // a
    mov r1, #4     // b
    mov r2, #3     // c
    bl calculate
    pop {pc}

calculate:
    push {r0-r2, lr}      
    sub r3, r0, r1
    cmp r3, #0
    ite ge
    addge r3, r0, r1
    sublt r3, r0, r1
    sdiv r3, r3, r2
    pop {r0-r2, pc}
