#include "browser.h"
#include "../drivers/screen.h"
#include "../libc/string.h"

#define MAX_HISTORY 10
#define MAX_URL_LEN 64

typedef struct {
    char url[MAX_URL_LEN];
    char title[80];
    char content[1024];
} Page;

static Page history[MAX_HISTORY];
static int history_index = -1;
static int history_size = 0;

// Base de données de pages web simulées
static const Page pages[] = {
    {
        "http://rafos.local",
        "RafOS Official Website",
        "\n"
        "  ===================================\n"
        "   Welcome to RafOS Official Site!\n"
        "  ===================================\n\n"
        "  About RafOS:\n"
        "  - Custom x86 Operating System\n"
        "  - Built from scratch in C and ASM\n"
        "  - Features: Shell, Browser, Apps\n\n"
        "  Quick Links:\n"
        "  - browse http://rafos.local/docs\n"
        "  - browse http://github.com/rafos\n\n"
    },
    {
        "http://rafos.local/docs",
        "RafOS Documentation",
        "\n"
        "  RafOS Documentation\n"
        "  ===================\n\n"
        "  Available Commands:\n"
        "  - help    : Show all commands\n"
        "  - clear   : Clear screen\n"
        "  - browse  : Open web pages\n"
        "  - back    : Previous page\n"
        "  - forward : Next page\n\n"
        "  For more info:\n"
        "  browse http://rafos.local\n\n"
    },
    {
        "http://google.com",
        "Google Search",
        "\n"
        "       _____                 _     \n"
        "      / ____|               | |    \n"
        "     | |  __  ___   ___   __| | ___\n"
        "     | | |_ |/ _ \\ / _ \\ / _` |/ _ \\\n"
        "     | |__| | (_) | (_) | (_| |  __/\n"
        "      \\_____|\\___/ \\___/ \\__,_|\\___|\n\n"
        "  Search functionality coming soon!\n"
        "  (Network stack in development)\n\n"
        "  Try other sites:\n"
        "  - browse http://wikipedia.org\n"
        "  - browse http://github.com\n\n"
    },
    {
        "http://wikipedia.org",
        "Wikipedia - The Free Encyclopedia",
        "\n"
        "  Wikipedia\n"
        "  =========\n\n"
        "  Featured Article: Operating Systems\n"
        "  ------------------------------------\n\n"
        "  An operating system (OS) is system\n"
        "  software that manages computer hardware\n"
        "  and software resources.\n\n"
        "  Common OS examples:\n"
        "  - Linux (Open Source)\n"
        "  - Windows (Microsoft)\n"
        "  - macOS (Apple)\n"
        "  - RafOS (You are here!)\n\n"
    },
    {
        "http://github.com",
        "GitHub - Where the world builds software",
        "\n"
        "   _____ _ _   _    _       _     \n"
        "  / ____(_) | | |  | |     | |    \n"
        " | |  __ _| |_| |__| |_   _| |__  \n"
        " | | |_ | | __|  __  | | | | '_ \\ \n"
        " | |__| | | |_| |  | | |_| | |_) |\n"
        "  \\_____|_|\\__|_|  |_|\\__,_|_.__/ \n\n"
        "  Check out RafOS on GitHub!\n"
        "  https://github.com/you/rafOS\n\n"
        "  Star the repo if you like it!\n\n"
    },
    {
        "http://stackoverflow.com",
        "Stack Overflow - Where Developers Learn",
        "\n"
        "  Stack Overflow\n"
        "  ==============\n\n"
        "  Top Question:\n"
        "  'How to write an OS from scratch?'\n\n"
        "  Answer (5000+ votes):\n"
        "  1. Learn C and Assembly\n"
        "  2. Understand x86 architecture\n"
        "  3. Write a bootloader\n"
        "  4. Implement basic drivers\n"
        "  5. Build a shell\n"
        "  6. You just did it with RafOS!\n\n"
    }
};

static const int pages_count = 6;

void browser_init() {
    history_index = -1;
    history_size = 0;
}

const Page* find_page(const char* url) {
    for (int i = 0; i < pages_count; i++) {
        if (strcmp(pages[i].url, url) == 0) {
            return &pages[i];
        }
    }
    return 0;
}

void add_to_history(const Page* page) {
    // Si on n'est pas au bout de l'historique, on efface le futur
    if (history_index < history_size - 1) {
        history_size = history_index + 1;
    }
    
    // Ajouter la page
    if (history_size < MAX_HISTORY) {
        history_index++;
        history_size++;
    } else {
        // Décaler l'historique
        for (int i = 0; i < MAX_HISTORY - 1; i++) {
            history[i] = history[i + 1];
        }
        history_index = MAX_HISTORY - 1;
    }
    
    // Copier la page
    strcpy(history[history_index].url, page->url);
    strcpy(history[history_index].title, page->title);
    strcpy(history[history_index].content, page->content);
}

void browser_navigate(const char* url) {
    const Page* page = find_page(url);
    
    if (page) {
        add_to_history(page);
        browser_show_current();
    } else {
        print("\n");
        print_color("  404 - Page Not Found\n", RED_ON_BLACK);
        print("  ===================\n\n");
        print("  The page '");
        print(url);
        print("' does not exist.\n\n");
        print("  Available sites:\n");
        print("  - http://rafos.local\n");
        print("  - http://google.com\n");
        print("  - http://wikipedia.org\n");
        print("  - http://github.com\n");
        print("  - http://stackoverflow.com\n\n");
    }
}

void browser_back() {
    if (history_index > 0) {
        history_index--;
        browser_show_current();
    } else {
        print("  Cannot go back (already at oldest page)\n");
    }
}

void browser_forward() {
    if (history_index < history_size - 1) {
        history_index++;
        browser_show_current();
    } else {
        print("  Cannot go forward (already at newest page)\n");
    }
}

void browser_home() {
    browser_navigate("http://rafos.local");
}

void browser_show_current() {
    if (history_index < 0) {
        print("  No page loaded. Try: browse http://rafos.local\n");
        return;
    }
    
    Page* page = &history[history_index];
    
    // Afficher la barre d'adresse
    print("\n");
    print_color("  ┌", CYAN_ON_BLACK);
    for (int i = 0; i < 70; i++) print_color("─", CYAN_ON_BLACK);
    print_color("┐\n", CYAN_ON_BLACK);
    
    print_color("  │ ", CYAN_ON_BLACK);
    print_color(page->url, WHITE_ON_BLACK);
    
    int padding = 68 - strlen(page->url);
    for (int i = 0; i < padding; i++) print(" ");
    print_color("│\n", CYAN_ON_BLACK);
    
    print_color("  └", CYAN_ON_BLACK);
    for (int i = 0; i < 70; i++) print_color("─", CYAN_ON_BLACK);
    print_color("┘\n", CYAN_ON_BLACK);
    
    // Afficher le titre
    print_color("\n  ", YELLOW_ON_BLACK);
    print_color(page->title, YELLOW_ON_BLACK);
    print("\n");
    
    // Afficher le contenu
    print(page->content);
    
    // Afficher les contrôles de navigation
    print_color("  Navigation: ", CYAN_ON_BLACK);
    if (history_index > 0) {
        print("[back] ");
    } else {
        print_color("[back] ", RED_ON_BLACK);
    }
    if (history_index < history_size - 1) {
        print("[forward] ");
    } else {
        print_color("[forward] ", RED_ON_BLACK);
    }
    print("[home]\n\n");
}

