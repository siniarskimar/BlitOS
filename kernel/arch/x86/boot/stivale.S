.section .stivalehdr
.long __stack_top   // stack_top
.long 0
.word 0b000         // flags
.word 0             // framebuffer_width
.word 0             // framebuffer_height
.word 0             // framebuffer_bpp
.long stivale_main  // entry_point
.long 0
