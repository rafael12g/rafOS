#include "timer.h"
#include "isr.h"
#include "../drivers/screen.h"
#include "../libc/string.h"

unsigned int tick = 0;

static void timer_callback(registers_t regs) {
    tick++;
}

void init_timer(unsigned int frequency) {
    register_interrupt_handler(IRQ0, timer_callback);
    
    unsigned int divisor = 1193180 / frequency;
    
    port_byte_out(0x43, 0x36);
    
    unsigned char l = (unsigned char)(divisor & 0xFF);
    unsigned char h = (unsigned char)((divisor >> 8) & 0xFF);
    
    port_byte_out(0x40, l);
    port_byte_out(0x40, h);
}
