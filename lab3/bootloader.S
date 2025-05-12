.syntax unified
.cpu cortex-m4
.thumb

.global bootload

.section .rodata
image: .incbin "kernel.bin"
end_of_image:
str_boot_start: .asciz "bootloader started"
str_boot_end: .asciz "bootloader end"

.section .text
bootload:
    ldr r0, =str_boot_start
    bl dbgput_line

    ldr r4, =end_of_image      // кінець .bin
    ldr r5, =image             // початок .bin
    ldr r6, =_ram_start        // початок місця в RAM

    mov r8, #12                
    sub r7, r4, r5             
    udiv r7, r7, r8            

    mul r9, r7, r8             
    add r5, r5, r9             
    add r6, r6, r9             

copy_loop:
    cmp r7, #0
    beq copy_done

    ldmdb r5!, {r0-r2}         
    stmdb r6!, {r0-r2}         

    subs r7, r7, #1
    b copy_loop

copy_done:
    bl newline
    ldr r0, =str_boot_end
    bl dbgput_line

    ldr r0, [r6, #4]           
    bx r0

    b .
