#include "screen.h"
#include "../cpu/ports.h"

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

void scroll_screen() {
    char* video = (char*) VIDEO_ADDRESS;
    
    // Copier toutes les lignes vers le haut
    for (int i = 1; i < MAX_ROWS; i++) {
        for (int j = 0; j < MAX_COLS * 2; j++) {
            video[(i - 1) * MAX_COLS * 2 + j] = video[i * MAX_COLS * 2 + j];
        }
    }
    
    // Effacer la dernière ligne
    for (int j = 0; j < MAX_COLS * 2; j += 2) {
        video[(MAX_ROWS - 1) * MAX_COLS * 2 + j] = ' ';
        video[(MAX_ROWS - 1) * MAX_COLS * 2 + j + 1] = WHITE_ON_BLACK;
    }
    
    cursor_row = MAX_ROWS - 1;
}

void print_char_at(char c, int col, int row, unsigned char attr) {
    char* video = (char*) VIDEO_ADDRESS;
    
    if (!attr) attr = WHITE_ON_BLACK;
    
    int offset = get_offset(col, row);
    
    if (c == '\n') {
        cursor_row++;
        cursor_col = 0;
    } else if (c == '\b') {
        if (cursor_col > 0) {
            cursor_col--;
            video[get_offset(cursor_col, cursor_row)] = ' ';
            video[get_offset(cursor_col, cursor_row) + 1] = attr;
        }
    } else {
        video[offset] = c;
        video[offset + 1] = attr;
        cursor_col++;
        
        if (cursor_col >= MAX_COLS) {
            cursor_col = 0;
            cursor_row++;
        }
    }
    
    if (cursor_row >= MAX_ROWS) {
        scroll_screen();
    }
    
    set_cursor(get_offset(cursor_col, cursor_row));
}

void print_char(char c) {
    print_char_at(c, cursor_col, cursor_row, WHITE_ON_BLACK);
}

void print(const char* str) {
    for (int i = 0; str[i] != 0; i++) {
        print_char(str[i]);
    }
}

void print_color(const char* str, unsigned char color) {
    for (int i = 0; str[i] != 0; i++) {
        print_char_at(str[i], cursor_col, cursor_row, color);
    }
}

void print_at(const char* str, int col, int row) {
    cursor_col = col;
    cursor_row = row;
    print(str);
}

void clear_screen() {
    char* video = (char*) VIDEO_ADDRESS;
    
    for (int i = 0; i < MAX_ROWS * MAX_COLS; i++) {
        video[i * 2] = ' ';
        video[i * 2 + 1] = WHITE_ON_BLACK;
    }
    
    cursor_row = 0;
    cursor_col = 0;
    set_cursor(0);
}
