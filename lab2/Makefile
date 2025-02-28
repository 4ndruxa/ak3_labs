# Налаштування тулчейну (інструментів для компіляції)
SDK_PREFIX ?= ~/ak3/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-

# Основні утиліти компіляції та лінкування
CC = $(SDK_PREFIX)gcc
LD = $(SDK_PREFIX)ld
SIZE = $(SDK_PREFIX)size
OBJCOPY = $(SDK_PREFIX)objcopy

# Налаштування QEMU для емуляції
QEMU = qemu-system-gnuarmeclipse
BOARD ?= STM32F4-Discovery
MCU = STM32F407VG
TCP_ADDR = 1234

# Назва вихідного файлу
TARGET = firmware

# Архітектура процесора
CPU_CC = cortex-m4

# Вхідні файли (асемблерний стартовий код та скрипт лінкування)
deps = start.S lscript.ld lab2.S

# Основна ціль для збірки прошивки
all: target

# Компіліруємо асемблерний код start.S у start.o
target:
	$(CC) -x assembler-with-cpp -c -O0 -g3 -mcpu=$(CPU_CC) -mthumb -Wall start.S -o start.o
	$(CC) -x assembler-with-cpp -c -O0 -g3 -mcpu=$(CPU_CC) -mthumb -Wall lab2.S -o lab2.o

	# Лінкуємо отримані об'єктні файли у виконуваний ELF
	$(CC) start.o lab2.o -mcpu=$(CPU_CC) -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T lscript.ld -o $(TARGET).elf

	# Конвертуємо ELF у бінарний формат, який можна прошити у мікроконтролер
	$(OBJCOPY) -O binary -F elf32-littlearm $(TARGET).elf $(TARGET).bin

# Команда для запуску емулятора QEMU
qemu:
	$(QEMU) --verbose --verbose --board $(BOARD) --mcu $(MCU) -d unimp,guest_errors \
	--image $(TARGET).bin --semihosting-config enable=on,target=native -gdb tcp::$(TCP_ADDR) -S

# Команда для очищення згенерованих файлів
clean:
	rm -f *.o   # Видаляємо об'єктні файли
	rm -f *.elf # Видаляємо виконувані файли ELF
	rm -f *.bin # Видаляємо бінарні файли прошивки
