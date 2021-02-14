ENTRY(_start)
PHDRS {
    none   PT_NULL FLAGS(0);
    text   PT_LOAD FLAGS((1 << 2) | (1 << 0) /* Readable | Executable */);
    data   PT_LOAD FLAGS((1 << 2) | (1 << 1) /* Readable | Writeable  */);
    rodata PT_LOAD FLAGS((1 << 2)            /* Readable */);
}
SECTIONS {
    .stivalehdr ALIGN(4K) : {
        *(.stivalehdr);
    }:none
    .stivale2hdr ALIGN(4K) : {
        *(.stivale2hdr);
    }
    
    . = 2M;
    .text ALIGN(4K) : {
        *(.text);
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
}