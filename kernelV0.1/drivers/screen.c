#include "screen.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f

static int cursor_row = 0;
static int cursor_col = 0;

int get_offset(int col, int row) {
    return 2 * (row * MAX_COLS + col);
}

void set_cursor(int offset) {
    offset /= 2;
    port_byte_out(0x3d4, 14);
    port_byte_out(0x3d5, (unsigned char)(offset >> 8));
    port_byte_out(0x3d4, 15);
    port_byte_out(0x3d5, (unsigned char)(offset & 0xff));
}

void print_char(char c, int col, int row, char attr) {
    unsigned char *vidmem = (unsigned char*) VIDEO_ADDRESS;
    
    if (!attr) attr = WHITE_ON_BLACK;
    
    if (col >= MAX_COLS || row >= MAX_ROWS) {
        vidmem[2*(MAX_COLS)*(MAX_ROWS)-2] = '!';
        vidmem[2*(MAX_COLS)*(MAX_ROWS)-1] = 0x0f;
        return;
    }
    
    int offset;
    if (col >= 0 && row >= 0) {
        offset = get_offset(col, row);
    } else {
        offset = get_offset(cursor_col, cursor_row);
    }
    
    if (c == '\n') {
        cursor_row++;
        cursor_col = 0;
    } else if (c == '\b') {
        if (cursor_col > 0) {
            cursor_col--;
            vidmem[offset-2] = ' ';
            vidmem[offset-1] = attr;
        }
    } else {
        vidmem[offset] = c;
        vidmem[offset+1] = attr;
        cursor_col++;
    }
    
    if (cursor_col >= MAX_COLS) {
        cursor_col = 0;
        cursor_row++;
    }
    
    if (cursor_row >= MAX_ROWS) {
        // Scroll
        for (int i = 1; i < MAX_ROWS; i++) {
            memory_copy(
                (char*)(VIDEO_ADDRESS + get_offset(0, i)),
                (char*)(VIDEO_ADDRESS + get_offset(0, i-1)),
                MAX_COLS * 2
            );
        }
        
        // Effacer dernière ligne
        char* last_line = (char*)(VIDEO_ADDRESS + get_offset(0, MAX_ROWS-1));
        for (int i = 0; i < MAX_COLS * 2; i++) {
            last_line[i] = 0;
        }
        
        cursor_row = MAX_ROWS - 1;
    }
    
    set_cursor(get_offset(cursor_col, cursor_row));
}

void print(char *message) {
    int i = 0;
    while (message[i] != 0) {
        print_char(message[i++], -1, -1, WHITE_ON_BLACK);
    }
}

void print_hex(unsigned int n) {
    char hex_string[9];
    hex_to_ascii(n, hex_string);
    print(hex_string);
}

void clear_screen() {
    for (int row = 0; row < MAX_ROWS; row++) {
        for (int col = 0; col < MAX_COLS; col++) {
            print_char(' ', col, row, WHITE_ON_BLACK);
        }
    }
    cursor_row = 0;
    cursor_col = 0;
    set_cursor(get_offset(cursor_col, cursor_row));
}
