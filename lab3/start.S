.syntax unified
.cpu cortex-m4
.thumb

.global vtable
.global __hard_reset__

.type vtable, %object
.type __hard_reset__, %function

.section .interrupt_vector
vtable:
    .word __stack_start
    .word __hard_reset__ + 1
    .size vtable, .-vtable

.section .text
__hard_reset__:
    .data
    d: .asciz "starting\n"
    .text
    ldr r0, =d
    bl dbgput_line     // виводимо повідомлення про запуск
    bl bootload        // переходимо в завантажувач
    _loop: b _loop    // якщо повернеться — зациклитись
    .size __hard_reset__, .-__hard_reset__
