[bits 32]
[extern kernel_main]        ; Déclaré dans kernel.c

global _start
_start:
    call kernel_main
    jmp $                   ; Boucle infinie si retour
