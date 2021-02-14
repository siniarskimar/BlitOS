.section .text
.global _start
/* If for some reason we get here */
/* Just halt-loop */
_start:
    hlt
    jmp _start