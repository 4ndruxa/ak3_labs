.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

// Global memory locations.
.global vtable
.global __hard_reset__

/*
* vector table
*/
.type vtable, %object
vtable:
    .word __stack_start
    .word __hard_reset__+1
.size vtable, .-vtable

__hard_reset__:
    ldr r0, =__stack_start  // Ініціалізація стеку
    mov sp, r0
    bl lab2                 // Виклик основної функції
_loop:
    b _loop                 // Нескінченний цикл
.size __hard_reset__, .-__hard_reset__
