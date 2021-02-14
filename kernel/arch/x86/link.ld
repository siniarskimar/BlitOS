ENTRY(_start)
PHDRS {
    none   PT_NULL FLAGS(0);
    text   PT_LOAD FLAGS((1 << 2) | (1 << 0) /* Readable | Executable */);
    data   PT_LOAD FLAGS((1 << 2) | (1 << 1) /* Readable | Writeable  */);
    rodata PT_LOAD FLAGS((1 << 2)            /* Readable */);
}

KERNEL_LMA = 3M;
KERNEL_VMA = 1024M * 3 + KERNEL_LMA;
SECTIONS {
    . = KERNEL_VMA;

    .text ALIGN(4K) : AT(ADDR(.text) - KERNEL_VMA) {
        KEEP(*(.init));
        *(.text);
        KEEP(*(.fini));
    }:text
    
    .rodata ALIGN(4K) :AT(ADDR(.rodata) - KERNEL_VMA) {
        *(.rodata);
    }:rodata

    .data ALIGN(4K) :AT(ADDR(.data) - KERNEL_VMA) {
        *(.data);
    }:data

    .bss ALIGN(4K) : AT(ADDR(.bss) - KERNEL_VMA){
        *(COMMON*);
        *(.bss*);
        . += 4K;
        __stack_top = .;
    }
}