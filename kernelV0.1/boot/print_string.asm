[bits 16]
print_string:
    pusha
    mov ah, 0x0e
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    mov al, 0x0a    ; Nouvelle ligne
    int 0x10
    mov al, 0x0d    ; Retour chariot
    int 0x10
    popa
    ret
