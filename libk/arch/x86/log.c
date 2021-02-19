#include <arch/x86/log/e9print.h>
#include <log.h>
#include <stddef.h>

void klog(const char* str) {
    e9_print(str);
}
void klogf(const char* format, ...) {
    va_list argp;
    va_start(argp, format);

    while (*format != '\0') {
        if (*format == '%') {
            format++;
            if (*format == 'x') {
                e9_putx(va_arg(argp, size_t));
            } else if (*format == 'd') {
                e9_putd(va_arg(argp, size_t));
            } else if (*format == 's') {
                e9_puts(va_arg(argp, char*));
            } 
        } else {
            e9_putc(*format);
        }
        format++;
    }

    va_end(argp);
}