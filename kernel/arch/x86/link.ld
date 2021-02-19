ENTRY(_start)
PHDRS {
    none   PT_NULL FLAGS(0);
    text   PT_LOAD FLAGS((1 << 2) | (1 << 0) /* Readable | Executable */);
    data   PT_LOAD FLAGS((1 << 2) | (1 << 1) /* Readable | Writeable  */);
    rodata PT_LOAD FLAGS((1 << 2)            /* Readable */);
}

KERNEL_LMA = 3M;
KERNEL_VMA = 3 * 1024M;
SECTIONS {
    . = KERNEL_LMA;
    .stivalehdr : {
        *(.stivalehdr);
    }
    __kernel_start = .;
    .text ALIGN(4K) :  {
        KEEP(*(.init));
        *(.text);
        KEEP(*(.fini));
    }:text
    
    .rodata ALIGN(4K) : {
        *(.rodata);
    }:rodata

    .data ALIGN(4K) : {
        *(.data);
    }:data

    .bss ALIGN(4K) : {
        *(COMMON*);
        *(.bss*);
        . += 4K;
        __stack_top = .;
    }
    __kernel_end = .;
}