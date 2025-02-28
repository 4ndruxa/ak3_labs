/* linker script for STM32F4 platforms
 * Define the end of RAM and limit of stack memory
 */
MEMORY
{
    /* STM32 чіпи мають флеш-пам'ять, що починається з 0x08000000 */
    FLASH ( rx ) : ORIGIN = 0x08000000, LENGTH = 1M

    /* ОЗП починається з 0x20000000, обсяг - 128KB */
    RAM ( rxw ) : ORIGIN = 0x20000000, LENGTH = 128K
}

__stack_start = ORIGIN(RAM) + LENGTH(RAM);
