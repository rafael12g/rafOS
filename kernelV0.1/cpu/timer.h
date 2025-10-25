#ifndef TIMER_H
#define TIMER_H

#include "../drivers/ports.h"

#define IRQ0 32

void init_timer(unsigned int frequency);

#endif
