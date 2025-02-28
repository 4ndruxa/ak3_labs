.global lab2
.syntax unified
.thumb

lab2:
    push {lr}          // Зберігаємо адресу повернення
    
    mov r0, #9         // a
    mov r1, #7         // b
    mov r2, #2         // c
    
    bl calculate       // Викликаємо функцію обчислення
    
    pop {pc}           // Повертаємось

calculate:
    push {r0, r1, r2, lr}   // Збереження регістрів
    
    sub r3, r0, r1          // r3 = a - b
    cmp r3, #0              // Порівнюємо (a - b) з 0
    ITE GE                  // If-Then-Else
    addGE r3, r0, r1        // Якщо (a - b) >= 0, r3 = a + b
    subLT r3, r0, r1        // Якщо (a - b) < 0, r3 = a - b
    
    sdiv r3, r3, r2         // Ділимо r3 на c: r3 = r3 / c

    pop {r0, r1, r2, pc}    // Відновлення регістрів і повернення
