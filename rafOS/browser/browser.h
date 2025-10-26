#ifndef BROWSER_H
#define BROWSER_H

void browser_init();
void browser_navigate(const char* url);
void browser_back();
void browser_forward();
void browser_home();
void browser_show_current();

#endif
