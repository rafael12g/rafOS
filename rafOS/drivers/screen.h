#ifndef SCREEN_H
#define SCREEN_H

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

// Couleurs
#define WHITE_ON_BLACK 0x0f
#define RED_ON_BLACK 0x04
#define GREEN_ON_BLACK 0x02
#define CYAN_ON_BLACK 0x0b
#define YELLOW_ON_BLACK 0x0e

void clear_screen();
void print(const char* str);
void print_char(char c);
void print_color(const char* str, unsigned char color);
void print_at(const char* str, int col, int row);

#endif
