.syntax unified
.cpu cortex-m4
.thumb

.global vtable_kernel
.global __kernel_reset__

.section .interrupt_vector
vtable_kernel:
    .word __stack_start
    .word __kernel_reset__ + 1

.section .rodata
start_msg: .asciz "kernel started\n"
result_msg: .asciz "Result: "

.section .text
__kernel_reset__:
    ldr r0, =start_msg
    bl dbgput_line                    // повідомлення про старт ядра

    bl lab2                           // виклик функції з обчисленням

    ldr r0, =result_msg
    bl dbgput                         // виводимо "Result: "
    mov r0, r3
    bl dbgput_num                     // виводимо обчислене значення

    b .

lab2:
    push {lr}
    mov r0, #8     // a
    mov r1, #4     // b
    mov r2, #3     // c
    bl calculate   // передаємо a, b, c
    pop {pc}

calculate:
    push {r0-r2, lr}
    sub r3, r0, r1           // r3 = a - b
    cmp r3, #0
    ite ge
    addge r3, r0, r1         // якщо a - b ≥ 0 → r3 = a + b
    sublt r3, r0, r1         // інакше → r3 = a - b
    sdiv r3, r3, r2          // ділимо результат на c
    pop {r0-r2, pc}
