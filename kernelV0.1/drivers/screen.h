#ifndef SCREEN_H
#define SCREEN_H

#include "ports.h"
#include "../libc/string.h"
#include "../libc/mem.h"

void clear_screen();
void print_char(char c, int col, int row, char attr);
void print(char *message);
void print_hex(unsigned int n);

#endif
