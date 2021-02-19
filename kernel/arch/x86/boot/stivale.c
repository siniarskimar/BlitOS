#include <boot/stivale.h>
#include <log.h>

void stivale_main(struct stivale_struct* info) {
    klog("Hello World!");
    while(1) ;
}