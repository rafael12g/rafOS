[BITS 16]
[ORG 0x0000]

start:
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0xFFFE
    
    call clear
    call boot_animation
    
    mov si, banner
    call print
    call nl
    
    mov si, msg_ready
    call print
    call nl
    call nl

shell:
    mov si, prompt
    call print
    
    call getline
    
    ; Check commands
    mov si, buffer
    mov di, cmd_help
    call strcmp
    jz do_help
    
    mov si, buffer
    mov di, cmd_clear
    call strcmp
    jz do_clear
    
    mov si, buffer
    mov di, cmd_calc
    call strcmp
    jz do_calc
    
    mov si, buffer
    mov di, cmd_about
    call strcmp
    jz do_about
    
    mov si, buffer
    mov di, cmd_time
    call strcmp
    jz do_time
    
    mov si, buffer
    mov di, cmd_mem
    call strcmp
    jz do_mem
    
    mov si, buffer
    mov di, cmd_echo
    call strcmp
    jz do_echo
    
    mov si, buffer
    mov di, cmd_beep
    call strcmp
    jz do_beep
    
    mov si, buffer
    mov di, cmd_reboot
    call strcmp
    jz do_reboot
    
    ; Unknown command
    cmp byte [buffer], 0
    je shell
    
    mov si, msg_unknown
    call print
    call nl
    jmp shell

do_help:
    mov si, txt_help
    call print
    jmp shell

do_clear:
    call clear
    jmp shell

do_calc:
    call calculator
    jmp shell

do_about:
    mov si, txt_about
    call print
    jmp shell

do_time:
    call show_time
    jmp shell

do_mem:
    call show_memory
    jmp shell

do_echo:
    mov si, buffer + 5
    call print
    call nl
    jmp shell

do_beep:
    call play_beep
    jmp shell

do_reboot:
    mov si, msg_reboot
    call print
    call nl
    call delay
    jmp 0xFFFF:0x0000

; ========== BOOT ANIMATION ==========
boot_animation:
    mov si, anim_load
    call print
    
    mov cx, 20
.loop:
    push cx
    mov al, '#'
    call printchar
    call short_delay
    pop cx
    loop .loop
    
    mov al, ']'
    call printchar
    call nl
    call nl
    ret

; ========== SHOW TIME ==========
show_time:
    call nl
    mov si, msg_time
    call print
    
    mov ah, 0x02
    int 0x1A
    
    mov al, ch
    call print_hex
    mov al, ':'
    call printchar
    
    mov al, cl
    call print_hex
    mov al, ':'
    call printchar
    
    mov al, dh
    call print_hex
    call nl
    call nl
    ret

print_hex:
    push ax
    shr al, 4
    call .digit
    pop ax
    and al, 0x0F
.digit:
    add al, '0'
    cmp al, '9'
    jle .ok
    add al, 7
.ok:
    call printchar
    ret

; ========== SHOW MEMORY ==========
show_memory:
    call nl
    mov si, msg_mem
    call print
    
    int 0x12
    call num2str
    mov si, numbuf
    call print
    mov si, msg_kb
    call print
    call nl
    call nl
    ret

; ========== BEEP ==========
play_beep:
    call nl
    mov si, msg_beep
    call print
    call nl
    
    ; Configure speaker
    in al, 0x61
    or al, 3
    out 0x61, al
    
    ; Play 3 beeps
    mov cx, 3
.loop:
    push cx
    
    ; Frequency
    mov al, 0xB6
    out 0x43, al
    mov ax, 1193
    out 0x42, al
    mov al, ah
    out 0x42, al
    
    ; Wait
    call delay
    
    ; Silence
    in al, 0x61
    and al, 0xFC
    out 0x61, al
    
    call short_delay
    
    ; Re-enable
    in al, 0x61
    or al, 3
    out 0x61, al
    
    pop cx
    loop .loop
    
    ; Final silence
    in al, 0x61
    and al, 0xFC
    out 0x61, al
    
    mov si, msg_done
    call print
    call nl
    ret

; ========== CALCULATOR ==========
calculator:
    call nl
    mov si, msg_calc
    call print
    call nl
    
    mov si, p_n1
    call print
    call getline
    call str2num
    mov [num1], ax
    
    mov si, p_op
    call print
    call getchar
    mov [operator], al
    call printchar
    call nl
    
    mov si, p_n2
    call print
    call getline
    call str2num
    mov [num2], ax
    
    mov ax, [num1]
    mov bx, [num2]
    mov cl, [operator]
    
    cmp cl, '+'
    je .add
    cmp cl, '-'
    je .sub
    cmp cl, '*'
    je .mul
    cmp cl, '/'
    je .div
    jmp .done
    
.add:
    add ax, bx
    jmp .show
.sub:
    sub ax, bx
    jmp .show
.mul:
    mul bx
    jmp .show
.div:
    test bx, bx
    jz .err
    xor dx, dx
    div bx
    jmp .show
.err:
    mov si, msg_err
    call print
    call nl
    call nl
    ret
    
.show:
    mov si, p_result
    call print
    call num2str
    mov si, numbuf
    call print
    call nl
    call nl
    
.done:
    ret

; ========== UTILITIES ==========
clear:
    push ax
    mov ax, 0x0003
    int 0x10
    pop ax
    ret

print:
    push ax
    push bx
.loop:
    lodsb
    test al, al
    jz .done
    call printchar
    jmp .loop
.done:
    pop bx
    pop ax
    ret

printchar:
    push ax
    push bx
    mov ah, 0x0E
    xor bh, bh
    int 0x10
    pop bx
    pop ax
    ret

nl:
    push ax
    mov al, 13
    call printchar
    mov al, 10
    call printchar
    pop ax
    ret

getchar:
    xor ah, ah
    int 0x16
    ret

getline:
    push di
    push cx
    mov di, buffer
    xor cx, cx
.loop:
    call getchar
    
    cmp al, 13
    je .done
    
    cmp al, 8
    je .back
    
    cmp cx, 60
    jge .loop
    
    mov [di], al
    inc di
    inc cx
    call printchar
    jmp .loop
    
.back:
    test cx, cx
    jz .loop
    dec di
    dec cx
    mov al, 8
    call printchar
    mov al, ' '
    call printchar
    mov al, 8
    call printchar
    jmp .loop
    
.done:
    mov byte [di], 0
    call nl
    pop cx
    pop di
    ret

strcmp:
    push ax
.loop:
    mov al, [si]
    mov ah, [di]
    cmp al, ah
    jne .diff
    test al, al
    jz .same
    inc si
    inc di
    jmp .loop
.same:
    pop ax
    xor ax, ax
    ret
.diff:
    pop ax
    mov ax, 1
    ret

str2num:
    push bx
    push cx
    push dx
    
    xor ax, ax
    xor cx, cx
    mov si, buffer
    
.loop:
    mov bl, [si]
    test bl, bl
    jz .done
    
    cmp bl, '0'
    jl .done
    cmp bl, '9'
    jg .done
    
    mov dx, 10
    mul dx
    
    sub bl, '0'
    xor bh, bh
    add ax, bx
    
    inc si
    jmp .loop
    
.done:
    pop dx
    pop cx
    pop bx
    ret

num2str:
    push bx
    push cx
    push dx
    
    mov bx, 10
    xor cx, cx
    mov di, numbuf
    
.loop:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    test ax, ax
    jnz .loop
    
.pop:
    pop ax
    mov [di], al
    inc di
    loop .pop
    
    mov byte [di], 0
    
    pop dx
    pop cx
    pop bx
    ret

delay:
    push cx
    mov cx, 0xFFFF
.loop:
    loop .loop
    pop cx
    ret

short_delay:
    push cx
    mov cx, 0x7FFF
.loop:
    loop .loop
    pop cx
    ret

; ========== DATA ==========
banner:
    db '================================', 13, 10
    db '     RafOS v1.2 - Simple OS    ', 13, 10
    db '================================', 0

anim_load: db 'Booting [', 0
msg_ready: db 'Ready! Type "help"', 0
prompt: db '> ', 0
msg_unknown: db 'Unknown command', 0

cmd_help: db 'help', 0
cmd_clear: db 'clear', 0
cmd_calc: db 'calc', 0
cmd_about: db 'about', 0
cmd_time: db 'time', 0
cmd_mem: db 'mem', 0
cmd_echo: db 'echo', 0
cmd_beep: db 'beep', 0
cmd_reboot: db 'reboot', 0

txt_help:
    db '--- Commands ---', 13, 10
    db 'help   - Show commands', 13, 10
    db 'clear  - Clear screen', 13, 10
    db 'calc   - Calculator', 13, 10
    db 'time   - Show time', 13, 10
    db 'mem    - Show memory', 13, 10
    db 'echo   - Echo text', 13, 10
    db 'beep   - Play beeps', 13, 10
    db 'about  - About RafOS', 13, 10
    db 'reboot - Reboot', 13, 10, 0

txt_about:
    db '', 13, 10
    db 'RafOS v1.2', 13, 10
    db 'Simple 16-bit OS', 13, 10
    db 'Written in x86 ASM', 13, 10, 0

msg_calc: db '=== Calculator ===', 0
p_n1: db 'Number 1: ', 0
p_op: db 'Operator (+,-,*,/): ', 0
p_n2: db 'Number 2: ', 0
p_result: db 'Result: ', 0
msg_err: db 'ERROR!', 0

msg_time: db 'Time: ', 0
msg_mem: db 'Memory: ', 0
msg_kb: db ' KB', 0
msg_beep: db 'Playing beeps...', 0
msg_done: db 'Done!', 0
msg_reboot: db 'Rebooting...', 0

num1: dw 0
num2: dw 0
operator: db 0
buffer: times 64 db 0
numbuf: times 12 db 0

times 10240-($-$$) db 0
