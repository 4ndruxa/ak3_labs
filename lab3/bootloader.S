.syntax unified
.cpu cortex-m4
.thumb

.global bootload

.section .rodata
image: .incbin "kernel.bin"              // підключення скомпільованого ядра
end_of_image:
str_boot_start: .asciz "bootloader started"
str_boot_end: .asciz "bootloader end"

.section .text
bootload:
    ldr r0, =str_boot_start
    bl dbgput_line                      // виводимо старт bootloader

    ldr r4, =end_of_image              // кінець .bin
    ldr r5, =image                     // початок .bin
    ldr r6, =_ram_start                // початок RAM, куди копіюємо

    mov r8, #12                        // варіант — копіювати по 12 байт
    sub r7, r4, r5                     // r7 = розмір у байтах
    udiv r7, r7, r8                    // r7 = кількість блоків по 12 байт

    mul r9, r7, r8                     // r9 = загальний розмір для зсуву
    add r5, r5, r9                     // r5 = останній байт образу
    add r6, r6, r9                     // r6 = куди останній блок потрапить у RAM

copy_loop:
    cmp r7, #0
    beq copy_done

    ldmdb r5!, {r0-r2}                // варіант 15: копіюємо з FLASH назад (LDMDB)
    stmdb r6!, {r0-r2}                // і записуємо в RAM назад (STMDB)

    subs r7, r7, #1
    b copy_loop

copy_done:
    bl newline
    ldr r0, =str_boot_end
    bl dbgput_line                    // bootloader завершив роботу

    ldr r0, [r6, #4]                  // зчитуємо адресу RESET з вектора ядра
    bx r0                             // стрибаємо в ядро

    b .                               
