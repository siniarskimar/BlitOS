#ifndef _BLIT_STRING_H
#define _BLIT_STRING_H

#include <stdint.h>
#include <stddef.h>

void memset(void* ptr, int val, size_t num);
size_t strlen(const char* str);
int strcpm(const char* str1, const char* str2);


#endif