CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

CPU = cortex-m4
CFLAGS = -mcpu=$(CPU) -mthumb -Wall -g -O0
LDFLAGS = -T

all: kernel.bin firmware.elf

kernel.bin: kernel.S print.S lscript_kernel.ld
	$(CC) $(CFLAGS) -c kernel.S -o kernel.o
	$(CC) $(CFLAGS) -c print.S -o print_kernel.o
	$(CC) -nostdlib kernel.o print_kernel.o -T lscript_kernel.ld -o kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

firmware.elf: start.S bootloader.S print.S lscript.ld
	$(CC) $(CFLAGS) -c start.S -o start.o
	$(CC) $(CFLAGS) -c bootloader.S -o bootloader.o
	$(CC) $(CFLAGS) -c print.S -o print.o
	$(CC) -nostdlib start.o bootloader.o print.o -T lscript.ld -o firmware.elf

clean:
	rm -f *.o *.elf *.bin
