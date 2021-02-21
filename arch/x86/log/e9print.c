#include <arch/x86/log/e9print.h>

void e9_putc(char c) {
    asm volatile ("out %%al, %%dx" :: "a" (c), "d" (0xE9) : "memory");
}
void e9_puts(const char* str) {
    for(size_t i = 0; str[i] != '\0'; i++) {
        e9_putc(str[i]);
    }
}
 
static inline void e9_itoa(size_t num, short base) {
    const char* CONV_TABLE = "0123456789abcdf";
    char buff[13];
    size_t t = num;
    short digits = 0;
    
    if(num == 0) {
        e9_putc('0');
        return;
    }
    while(t != 0) {
        t /= base;
        digits++;
    }
    char* ptr = buff + digits;
    while(ptr != buff) {
        *ptr = CONV_TABLE[num % base];
        num /= base;
        ptr--;
    }
    e9_puts(buff);
}
void e9_putd(size_t num) {
    e9_itoa(num, 10);
}
void e9_putx(size_t num) {
    e9_puts("0x");
    e9_itoa(num, 16);
}
void e9_print(const char* str) {
    e9_puts(str);
    e9_putc('\n');
}