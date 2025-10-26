#include "keyboard.h"
#include "../cpu/ports.h"

#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64

static char key_buffer[256];
static int buffer_read = 0;
static int buffer_write = 0;

// Scancode to ASCII map (US keyboard)
static const char scancode_to_ascii[] = {
    0, 0, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
    '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
    0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`',
    0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0,
    '*', 0, ' '
};

static const char scancode_to_ascii_shift[] = {
    0, 0, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '\b',
    '\t', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n',
    0, 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~',
    0, '|', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?', 0,
    '*', 0, ' '
};

static int shift_pressed = 0;

void keyboard_handler() {
    unsigned char scancode = port_byte_in(KEYBOARD_DATA_PORT);
    
    // Gérer Shift
    if (scancode == 0x2A || scancode == 0x36) {
        shift_pressed = 1;
        return;
    }
    if (scancode == 0xAA || scancode == 0xB6) {
        shift_pressed = 0;
        return;
    }
    
    // Ignorer les release codes
    if (scancode & 0x80) {
        return;
    }
    
    // Convertir scancode en ASCII
    char ascii = 0;
    if (scancode < 58) {
        ascii = shift_pressed ? scancode_to_ascii_shift[scancode] : scancode_to_ascii[scancode];
    }
    
    if (ascii != 0) {
        key_buffer[buffer_write] = ascii;
        buffer_write = (buffer_write + 1) % 256;
    }
}

void init_keyboard() {
    buffer_read = 0;
    buffer_write = 0;
    shift_pressed = 0;
}

int keyboard_available() {
    // Vérifier si le contrôleur a des données
    unsigned char status = port_byte_in(KEYBOARD_STATUS_PORT);
    if (status & 0x01) {
        keyboard_handler();
    }
    
    return buffer_read != buffer_write;
}

char keyboard_getchar() {
    while (!keyboard_available()) {
        // Attendre qu'une touche soit disponible
    }
    
    char c = key_buffer[buffer_read];
    buffer_read = (buffer_read + 1) % 256;
    return c;
}
