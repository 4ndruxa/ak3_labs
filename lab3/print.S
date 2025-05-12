.thumb
.syntax unified
.cpu cortex-m4

#define SEMIHOSTING_SYS_WRITE0  #0x04
#define SEMIHOSTING             #0xAB

.section .data
str_hex: .asciz "0xXXXXXXXX\n"

.text
.global dbgput_line
.global dbgput
.global newline
.global dbgput_num

dbgput:
    push {lr}
    mov r1, r0
    mov r0, SEMIHOSTING_SYS_WRITE0
    bkpt SEMIHOSTING
    pop {pc}

_newline_sym: .asciz "\n\r"
.align 4

dbgput_line:
    push {lr}
    mov r1, r0
    mov r0, SEMIHOSTING_SYS_WRITE0
    bkpt SEMIHOSTING
    ldr r1, =_newline_sym
    mov r0, SEMIHOSTING_SYS_WRITE0
    bkpt SEMIHOSTING
    pop {pc}

newline:
    push {lr}
    ldr r1, =_newline_sym
    mov r0, SEMIHOSTING_SYS_WRITE0
    bkpt SEMIHOSTING
    pop {pc}

dbgput_num:
    push {r1-r5, lr}
    mov r2, #9              
    mov r3, #0xF            
    ldr r1, =str_hex
    mov r4, r0              

next:
    and r5, r4, r3          
    add r5, r5, #48         
    cmp r5, #58             
    blo store
    add r5, r5, #7
store:
    strb r5, [r1, r2]
    lsr r4, r4, #4          
    subs r2, r2, #1
    cmp r2, #2
    bge next

    ldr r1, =str_hex
    mov r0, #0x04
    bkpt #0xAB
    pop {r1-r5, pc}
