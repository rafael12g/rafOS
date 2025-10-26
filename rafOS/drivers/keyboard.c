#include "keyboard.h"
#include "../cpu/ports.h"

#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64

// Scancode -> ASCII (QWERTY)
static char scancode_to_ascii[128] = {
    0,  27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
    '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
    0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`',
    0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0,
    '*', 0, ' '
};

// Avec SHIFT
static char scancode_to_ascii_shift[128] = {
    0,  27, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '\b',
    '\t', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n',
    0, 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~',
    0, '|', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?', 0,
    '*', 0, ' '
};

static int shift_pressed = 0;

void init_keyboard() {
    // Vider le buffer
    while (port_byte_in(KEYBOARD_STATUS_PORT) & 0x1) {
        port_byte_in(KEYBOARD_DATA_PORT);
    }
}

int keyboard_available() {
    return (port_byte_in(KEYBOARD_STATUS_PORT) & 0x1);
}

char keyboard_getchar() {
    if (!keyboard_available()) return 0;
    
    unsigned char scancode = port_byte_in(KEYBOARD_DATA_PORT);
    
    // SHIFT pressé
    if (scancode == 0x2A || scancode == 0x36) {
        shift_pressed = 1;
        return 0;
    }
    
    // SHIFT relâché
    if (scancode == 0xAA || scancode == 0xB6) {
        shift_pressed = 0;
        return 0;
    }
    
    // Ignorer les release codes (bit 7 = 1)
    if (scancode & 0x80) return 0;
    
    // Convertir le scancode en ASCII
    if (scancode < 128) {
        return shift_pressed ? scancode_to_ascii_shift[scancode] : scancode_to_ascii[scancode];
    }
    
    return 0;
}
