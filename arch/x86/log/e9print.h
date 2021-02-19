#ifndef _BLIT_X86_E9PRINT_H
#define _BLIT_X86_E9PRINT_H

#include <stddef.h>

void e9_putc(char c);
void e9_putd(size_t num);
void e9_putx(size_t num);
void e9_puts(const char* str);
void e9_print(const char* str);

#endif