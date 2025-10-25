#include "keyboard.h"
#include "screen.h"
#include "../cpu/isr.h"

const char scancode_to_char[] = {
    0, 0, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
    '\t', 'a', 'z', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
    0, 'q', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', '\'', '`', 0,
    '\\', 'w', 'x', 'c', 'v', 'b', 'n', ',', ';', ':', '!', 0, '*', 0, ' '
};

static void keyboard_callback(registers_t regs) {
    unsigned char scancode = port_byte_in(0x60);
    
    if (scancode & 0x80) {
        // Touche relâchée
    } else {
        // Touche pressée
        if (scancode < 58) {
            char c = scancode_to_char[scancode];
            if (c) {
                char str[2] = {c, '\0'};
                print(str);
            }
        }
    }
}

void init_keyboard() {
    register_interrupt_handler(IRQ1, keyboard_callback);
}
