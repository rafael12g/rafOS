[BITS 16]
[ORG 0x0000]

start:
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0xFFFE
    
    call init_system
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
    ; Prompt coloré: user@host:dir$
    mov byte [color], 0x0B
    mov si, env_user
    call print
    mov al, '@'
    call printchar
    mov si, env_host
    call print
    mov al, ':'
    call printchar
    mov byte [color], 0x0E
    mov si, current_dir
    call print
    mov byte [color], 0x0F
    mov al, '$'
    call printchar
    mov al, ' '
    call printchar
    
    call getline_advanced
    call save_history
    call parse_command
    
    ; Commands
    mov si, cmd_buffer
    mov di, cmd_help
    call strcmp
    jz do_help
    
    mov si, cmd_buffer
    mov di, cmd_clear
    call strcmp
    jz do_clear
    
    mov si, cmd_buffer
    mov di, cmd_ls
    call strcmp
    jz do_ls
    
    mov si, cmd_buffer
    mov di, cmd_pwd
    call strcmp
    jz do_pwd
    
    mov si, cmd_buffer
    mov di, cmd_cd
    call strcmp
    jz do_cd
    
    mov si, cmd_buffer
    mov di, cmd_mkdir
    call strcmp
    jz do_mkdir
    
    mov si, cmd_buffer
    mov di, cmd_touch
    call strcmp
    jz do_touch
    
    mov si, cmd_buffer
    mov di, cmd_cat
    call strcmp
    jz do_cat
    
    mov si, cmd_buffer
    mov di, cmd_edit
    call strcmp
    jz do_edit
    
    mov si, cmd_buffer
    mov di, cmd_rm
    call strcmp
    jz do_rm
    
    mov si, cmd_buffer
    mov di, cmd_cp
    call strcmp
    jz do_cp
    
    mov si, cmd_buffer
    mov di, cmd_mv
    call strcmp
    jz do_mv
    
    mov si, cmd_buffer
    mov di, cmd_echo
    call strcmp
    jz do_echo
    
    mov si, cmd_buffer
    mov di, cmd_set
    call strcmp
    jz do_set
    
    mov si, cmd_buffer
    mov di, cmd_env
    call strcmp
    jz do_env
    
    mov si, cmd_buffer
    mov di, cmd_history
    call strcmp
    jz do_history
    
    mov si, cmd_buffer
    mov di, cmd_calc
    call strcmp
    jz do_calc
    
    mov si, cmd_buffer
    mov di, cmd_time
    call strcmp
    jz do_time
    
    mov si, cmd_buffer
    mov di, cmd_mem
    call strcmp
    jz do_mem
    
    mov si, cmd_buffer
    mov di, cmd_beep
    call strcmp
    jz do_beep
    
    mov si, cmd_buffer
    mov di, cmd_about
    call strcmp
    jz do_about
    
    mov si, cmd_buffer
    mov di, cmd_reboot
    call strcmp
    jz do_reboot
    
    cmp byte [cmd_buffer], 0
    je shell
    
    call check_script
    jz shell
    
    mov si, msg_unknown
    call print
    call nl
    jmp shell

init_system:
    mov word [history_count], 0
    mov word [history_pos], 0
    mov word [file_count], 0
    
    mov si, str_root
    mov di, current_dir
    call strcpy
    
    mov si, str_user_def
    mov di, env_user
    call strcpy
    
    mov si, str_host_def
    mov di, env_host
    call strcpy
    
    mov si, file1_name
    mov di, files
    call strcpy
    
    mov si, file1_content
    mov di, files + 32
    call strcpy
    
    inc word [file_count]
    ret

do_help:
    call clear
    
    ; Page 1
    mov byte [color], 0x0E
    mov si, help_title
    call print
    call nl
    mov byte [color], 0x0F
    mov si, help_line
    call print
    call nl
    call nl
    
    ; File System
    mov byte [color], 0x0B
    mov si, help_cat_fs
    call print
    call nl
    mov byte [color], 0x0F
    
    mov si, help_ls
    call print
    call nl
    mov si, help_pwd
    call print
    call nl
    mov si, help_cd
    call print
    call nl
    mov si, help_mkdir
    call print
    call nl
    mov si, help_touch
    call print
    call nl
    mov si, help_cat
    call print
    call nl
    mov si, help_edit
    call print
    call nl
    mov si, help_rm
    call print
    call nl
    mov si, help_cp
    call print
    call nl
    mov si, help_mv
    call print
    call nl
    call nl
    
    ; Shell
    mov byte [color], 0x0B
    mov si, help_cat_shell
    call print
    call nl
    mov byte [color], 0x0F
    
    mov si, help_echo
    call print
    call nl
    mov si, help_set
    call print
    call nl
    
    ; Pagination
    mov byte [color], 0x0E
    mov si, msg_more
    call print
    mov byte [color], 0x0F
    call getchar
    
    ; Page 2
    call clear
    
    mov byte [color], 0x0E
    mov si, help_title
    call print
    mov si, msg_page2
    call print
    call nl
    mov byte [color], 0x0F
    mov si, help_line
    call print
    call nl
    call nl
    
    ; Shell suite
    mov byte [color], 0x0B
    mov si, help_cat_shell
    call print
    mov si, msg_cont
    call print
    call nl
    mov byte [color], 0x0F
    
    mov si, help_env
    call print
    call nl
    mov si, help_history
    call print
    call nl
    call nl
    
    ; System
    mov byte [color], 0x0B
    mov si, help_cat_sys
    call print
    call nl
    mov byte [color], 0x0F
    
    mov si, help_calc
    call print
    call nl
    mov si, help_time
    call print
    call nl
    mov si, help_mem
    call print
    call nl
    mov si, help_beep
    call print
    call nl
    mov si, help_about
    call print
    call nl
    mov si, help_clear
    call print
    call nl
    mov si, help_reboot
    call print
    call nl
    call nl
    
    ; Tips
    mov byte [color], 0x0D
    mov si, help_tips
    call print
    call nl
    mov byte [color], 0x07
    
    mov si, help_tip1
    call print
    call nl
    mov si, help_tip2
    call print
    call nl
    mov si, help_tip3
    call print
    call nl
    call nl
    
    mov byte [color], 0x0E
    mov si, msg_press_key
    call print
    mov byte [color], 0x0F
    call getchar
    
    call clear
    jmp shell

do_clear:
    call clear
    jmp shell

do_ls:
    call nl
    mov si, msg_listing
    call print
    call nl
    
    mov cx, [file_count]
    test cx, cx
    jz .empty
    
    xor bx, bx
.loop:
    push cx
    push bx
    
    mov ax, 128
    mul bx
    mov si, files
    add si, ax
    
    mov byte [color], 0x0A
    call print
    mov byte [color], 0x0F
    call nl
    
    pop bx
    inc bx
    pop cx
    loop .loop
    jmp .done
    
.empty:
    mov si, msg_empty
    call print
    call nl
    
.done:
    call nl
    jmp shell

do_pwd:
    call nl
    mov si, current_dir
    call print
    call nl
    call nl
    jmp shell

do_cd:
    mov si, arg1
    cmp byte [si], 0
    je .root
    
    mov di, current_dir
    call strcpy
    jmp .done
    
.root:
    mov si, str_root
    mov di, current_dir
    call strcpy
    
.done:
    jmp shell

do_mkdir:
    mov si, arg1
    cmp byte [si], 0
    je .usage
    
    call nl
    mov si, msg_created
    call print
    mov si, arg1
    call print
    call nl
    call nl
    jmp shell
    
.usage:
    mov si, msg_usage_mkdir
    call print
    call nl
    jmp shell

do_touch:
    mov si, arg1
    cmp byte [si], 0
    je .usage
    
    mov ax, [file_count]
    cmp ax, 10
    jge .full
    
    mov bx, 128
    mul bx
    mov di, files
    add di, ax
    
    mov si, arg1
    call strcpy
    
    inc word [file_count]
    
    call nl
    mov si, msg_created
    call print
    mov si, arg1
    call print
    call nl
    call nl
    jmp shell
    
.usage:
    mov si, msg_usage_touch
    call print
    call nl
    jmp shell
    
.full:
    mov si, msg_disk_full
    call print
    call nl
    jmp shell

do_cat:
    mov si, arg1
    cmp byte [si], 0
    je .usage
    
    call nl
    mov si, msg_reading
    call print
    mov si, arg1
    call print
    call nl
    
    call find_file
    test ax, ax
    jz .not_found
    
    add ax, 32
    mov si, ax
    call print
    call nl
    call nl
    jmp shell
    
.usage:
    mov si, msg_usage_cat
    call print
    call nl
    jmp shell
    
.not_found:
    mov si, msg_not_found
    call print
    call nl
    jmp shell

do_edit:
    mov si, arg1
    cmp byte [si], 0
    je .usage
    
    call text_editor
    jmp shell
    
.usage:
    mov si, msg_usage_edit
    call print
    call nl
    jmp shell

do_rm:
    mov si, arg1
    cmp byte [si], 0
    je .usage
    
    call nl
    mov si, msg_deleted
    call print
    mov si, arg1
    call print
    call nl
    call nl
    jmp shell
    
.usage:
    mov si, msg_usage_rm
    call print
    call nl
    jmp shell

do_cp:
    mov si, arg1
    cmp byte [si], 0
    je .usage
    mov si, arg2
    cmp byte [si], 0
    je .usage
    
    call nl
    mov si, msg_copied
    call print
    call nl
    jmp shell
    
.usage:
    mov si, msg_usage_cp
    call print
    call nl
    jmp shell

do_mv:
    mov si, arg1
    cmp byte [si], 0
    je .usage
    mov si, arg2
    cmp byte [si], 0
    je .usage
    
    call nl
    mov si, msg_moved
    call print
    call nl
    jmp shell
    
.usage:
    mov si, msg_usage_mv
    call print
    call nl
    jmp shell

do_echo:
    call nl
    mov si, arg1
    call print
    call nl
    call nl
    jmp shell

do_set:
    mov si, arg1
    cmp byte [si], 0
    je .show_all
    
    mov al, [arg1]
    cmp al, 'U'
    je .maybe_user
    cmp al, 'H'
    je .maybe_host
    jmp shell
    
.maybe_user:
    mov si, arg1 + 5
    mov di, env_user
    call strcpy
    jmp shell
    
.maybe_host:
    mov si, arg1 + 5
    mov di, env_host
    call strcpy
    jmp shell
    
.show_all:
    call do_env
    jmp shell

do_env:
    call nl
    mov si, msg_env
    call print
    call nl
    
    mov si, str_user_var
    call print
    mov al, '='
    call printchar
    mov si, env_user
    call print
    call nl
    
    mov si, str_host_var
    call print
    mov al, '='
    call printchar
    mov si, env_host
    call print
    call nl
    
    mov si, str_path_var
    call print
    mov al, '='
    call printchar
    mov si, env_path
    call print
    call nl
    call nl
    jmp shell

do_history:
    call nl
    mov cx, [history_count]
    test cx, cx
    jz .empty
    
    xor bx, bx
.loop:
    push cx
    push bx
    
    mov ax, bx
    inc ax
    call num2str
    mov si, numbuf
    call print
    mov si, str_space
    call print
    
    mov ax, 64
    mul bx
    mov si, history
    add si, ax
    call print
    call nl
    
    pop bx
    inc bx
    pop cx
    loop .loop
    jmp .done
    
.empty:
    mov si, msg_no_history
    call print
    call nl
    
.done:
    call nl
    jmp shell

do_calc:
    call calculator
    jmp shell

do_time:
    call show_time
    jmp shell

do_mem:
    call show_memory
    jmp shell

do_beep:
    call play_beep
    jmp shell

do_about:
    mov si, txt_about
    call print
    jmp shell

do_reboot:
    mov si, msg_reboot
    call print
    call nl
    call delay
    jmp 0xFFFF:0x0000

text_editor:
    call clear
    
    mov si, msg_editor
    call print
    mov si, arg1
    call print
    call nl
    mov si, msg_editor_help
    call print
    call nl
    call nl
    
    call find_file
    test ax, ax
    jz .new_file
    
    add ax, 32
    mov si, ax
    mov di, edit_buffer
    call strcpy
    jmp .start_edit
    
.new_file:
    mov byte [edit_buffer], 0
    
.start_edit:
    mov si, edit_buffer
    call print
    
    mov di, edit_buffer
    mov cx, 0
    
.edit_loop:
    call getchar
    
    cmp al, 27
    je .save
    
    cmp al, 13
    je .newline
    
    cmp al, 8
    je .backspace
    
    cmp cx, 500
    jge .edit_loop
    
    mov [di], al
    inc di
    inc cx
    call printchar
    jmp .edit_loop
    
.newline:
    mov byte [di], 13
    inc di
    inc cx
    mov byte [di], 10
    inc di
    inc cx
    call nl
    jmp .edit_loop
    
.backspace:
    test cx, cx
    jz .edit_loop
    dec di
    dec cx
    mov al, 8
    call printchar
    mov al, ' '
    call printchar
    mov al, 8
    call printchar
    jmp .edit_loop
    
.save:
    mov byte [di], 0
    
    call find_file
    test ax, ax
    jnz .update
    
    mov ax, [file_count]
    mov bx, 128
    mul bx
    mov di, files
    add di, ax
    
    mov si, arg1
    call strcpy
    
    add di, 32
    mov si, edit_buffer
    call strcpy
    
    inc word [file_count]
    jmp .done
    
.update:
    add ax, 32
    mov di, ax
    mov si, edit_buffer
    call strcpy
    
.done:
    call nl
    mov si, msg_saved
    call print
    call nl
    call delay
    call clear
    ret

getline_advanced:
    push di
    push cx
    mov di, buffer
    xor cx, cx
    mov word [buffer_pos], 0
    
.loop:
    call getchar
    
    cmp ah, 0x48
    je .up_arrow
    
    cmp ah, 0x50
    je .down_arrow
    
    cmp al, 9
    je .tab
    
    cmp al, 13
    je .done
    
    cmp al, 8
    je .backspace
    
    cmp cx, 60
    jge .loop
    
    mov [di], al
    inc di
    inc cx
    inc word [buffer_pos]
    call printchar
    jmp .loop
    
.up_arrow:
    call history_up
    jmp .loop
    
.down_arrow:
    call history_down
    jmp .loop
    
.tab:
    call auto_complete
    jmp .loop
    
.backspace:
    test cx, cx
    jz .loop
    dec di
    dec cx
    dec word [buffer_pos]
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

history_up:
    mov ax, [history_pos]
    test ax, ax
    jz .ret
    
    dec ax
    mov [history_pos], ax
    
    call load_history
    
.ret:
    ret

history_down:
    mov ax, [history_pos]
    inc ax
    cmp ax, [history_count]
    jge .ret
    
    mov [history_pos], ax
    call load_history
    
.ret:
    ret

load_history:
    mov cx, [buffer_pos]
.clear_loop:
    test cx, cx
    jz .load
    mov al, 8
    call printchar
    mov al, ' '
    call printchar
    mov al, 8
    call printchar
    dec cx
    jmp .clear_loop
    
.load:
    mov ax, [history_pos]
    mov bx, 64
    mul bx
    mov si, history
    add si, ax
    
    mov di, buffer
    xor cx, cx
    
.copy:
    lodsb
    test al, al
    jz .done
    
    mov [di], al
    inc di
    inc cx
    call printchar
    jmp .copy
    
.done:
    mov byte [di], 0
    mov [buffer_pos], cx
    ret

save_history:
    cmp byte [buffer], 0
    je .ret
    
    mov ax, [history_count]
    cmp ax, 20
    jge .ret
    
    mov bx, 64
    mul bx
    mov di, history
    add di, ax
    
    mov si, buffer
    call strcpy
    
    inc word [history_count]
    mov ax, [history_count]
    mov [history_pos], ax
    
.ret:
    ret

auto_complete:
    mov al, [buffer]
    cmp al, 'h'
    jne .ret
    
    cmp byte [buffer+1], 0
    jne .ret
    
    mov si, cmd_help
    mov di, buffer
    call strcpy
    
    mov si, buffer + 1
    call print
    mov word [buffer_pos], 4
    
.ret:
    ret

parse_command:
    mov si, buffer
    mov di, cmd_buffer
    xor cx, cx
    
.get_cmd:
    lodsb
    test al, al
    jz .done
    cmp al, ' '
    je .get_arg1
    
    mov [di], al
    inc di
    jmp .get_cmd
    
.get_arg1:
    mov byte [di], 0
    
.skip1:
    lodsb
    cmp al, ' '
    je .skip1
    test al, al
    jz .done
    
    mov di, arg1
.copy1:
    mov [di], al
    inc di
    lodsb
    test al, al
    jz .done
    cmp al, ' '
    je .get_arg2
    jmp .copy1
    
.get_arg2:
    mov byte [di], 0
    
.skip2:
    lodsb
    cmp al, ' '
    je .skip2
    test al, al
    jz .done
    
    mov di, arg2
.copy2:
    mov [di], al
    inc di
    lodsb
    test al, al
    jz .done
    jmp .copy2
    
.done:
    mov byte [di], 0
    ret

check_script:
    mov si, cmd_buffer
    xor cx, cx
    
.find_end:
    lodsb
    test al, al
    jz .check
    inc cx
    jmp .find_end
    
.check:
    cmp cx, 3
    jl .not_script
    
    sub si, 4
    mov al, [si]
    cmp al, '.'
    jne .not_script
    inc si
    mov al, [si]
    cmp al, 's'
    jne .not_script
    inc si
    mov al, [si]
    cmp al, 'h'
    jne .not_script
    
    call execute_script
    xor ax, ax
    ret
    
.not_script:
    mov ax, 1
    ret

execute_script:
    call nl
    mov si, msg_exec_script
    call print
    mov si, cmd_buffer
    call print
    call nl
    
    mov si, cmd_buffer
    mov di, arg1
    call strcpy
    
    call find_file
    test ax, ax
    jz .not_found
    
    add ax, 32
    mov si, ax
    call print
    call nl
    ret
    
.not_found:
    mov si, msg_not_found
    call print
    call nl
    ret

find_file:
    push cx
    push di
    
    mov cx, [file_count]
    test cx, cx
    jz .not_found
    
    xor bx, bx
.loop:
    push cx
    
    mov ax, 128
    mul bx
    mov di, files
    add di, ax
    
    mov si, arg1
    call strcmp
    jz .found
    
    inc bx
    pop cx
    loop .loop
    
.not_found:
    xor ax, ax
    pop di
    pop cx
    ret
    
.found:
    pop cx
    mov ax, 128
    mul bx
    add ax, files
    pop di
    pop cx
    ret

calculator:
    call nl
    mov si, msg_calc
    call print
    call nl
    
    mov si, p_n1
    call print
    call getline_simple
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
    call getline_simple
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

play_beep:
    call nl
    mov si, msg_beep
    call print
    call nl
    
    in al, 0x61
    or al, 3
    out 0x61, al
    
    mov cx, 3
.loop:
    push cx
    
    mov al, 0xB6
    out 0x43, al
    mov ax, 1193
    out 0x42, al
    mov al, ah
    out 0x42, al
    
    call delay
    
    in al, 0x61
    and al, 0xFC
    out 0x61, al
    
    call short_delay
    
    in al, 0x61
    or al, 3
    out 0x61, al
    
    pop cx
    loop .loop
    
    in al, 0x61
    and al, 0xFC
    out 0x61, al
    
    mov si, msg_done
    call print
    call nl
    ret

boot_animation:
    mov si, anim_load
    call print
    
    mov cx, 25
.loop:
    push cx
    mov al, '='
    call printchar
    call short_delay
    pop cx
    loop .loop
    
    mov al, ']'
    call printchar
    call nl
    call nl
    ret

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
    
    mov ah, 0x09
    xor bh, bh
    mov bl, [color]
    mov cx, 1
    int 0x10
    
    mov ah, 0x0E
    xor bh, bh
    int 0x10
    
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

getline_simple:
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

strcpy:
    push ax
.loop:
    lodsb
    mov [di], al
    inc di
    test al, al
    jnz .loop
    pop ax
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

delay:
    push cx
    mov cx, 0xFFFF
.loop:
    loop .loop
    pop cx
    ret

short_delay:
    push cx
    mov cx, 0x3FFF
.loop:
    loop .loop
    pop cx
    ret

; ========== DATA ==========
banner:
    db '================================', 13, 10
    db '       RafOS v2.0 Advanced     ', 13, 10
    db '================================', 0

anim_load: db 'Booting [', 0
msg_ready: db 'Welcome! Type "help"', 0

cmd_help: db 'help', 0
cmd_clear: db 'clear', 0
cmd_ls: db 'ls', 0
cmd_pwd: db 'pwd', 0
cmd_cd: db 'cd', 0
cmd_mkdir: db 'mkdir', 0
cmd_touch: db 'touch', 0
cmd_cat: db 'cat', 0
cmd_edit: db 'edit', 0
cmd_rm: db 'rm', 0
cmd_cp: db 'cp', 0
cmd_mv: db 'mv', 0
cmd_echo: db 'echo', 0
cmd_set: db 'set', 0
cmd_env: db 'env', 0
cmd_history: db 'history', 0
cmd_calc: db 'calc', 0
cmd_time: db 'time', 0
cmd_mem: db 'mem', 0
cmd_beep: db 'beep', 0
cmd_about: db 'about', 0
cmd_reboot: db 'reboot', 0

help_title: db '=== RafOS v2.0 - HELP ===', 0
help_line: db '================================', 0
msg_page2: db ' [Page 2/2]', 0
msg_cont: db ' (continued)', 0
msg_more: db '--- Press any key for more ---', 0
msg_press_key: db '--- Press any key to return ---', 0

help_cat_fs: db '[File System]', 0
help_ls: db '  ls            List files', 0
help_pwd: db '  pwd           Show current directory', 0
help_cd: db '  cd [dir]      Change directory', 0
help_mkdir: db '  mkdir [name]  Create directory', 0
help_touch: db '  touch [file]  Create new file', 0
help_cat: db '  cat [file]    Display file content', 0
help_edit: db '  edit [file]   Edit file (ESC to save)', 0
help_rm: db '  rm [file]     Delete file', 0
help_cp: db '  cp [src] [dst] Copy file', 0
help_mv: db '  mv [src] [dst] Move/rename file', 0

help_cat_shell: db '[Shell]', 0
help_echo: db '  echo [text]   Print text', 0
help_set: db '  set VAR=value Set variable', 0
help_env: db '  env           Show environment', 0
help_history: db '  history       Show command history', 0

help_cat_sys: db '[System]', 0
help_calc: db '  calc          Calculator', 0
help_time: db '  time          Show system time', 0
help_mem: db '  mem           Show memory info', 0
help_beep: db '  beep          Play sound', 0
help_about: db '  about         About RafOS', 0
help_clear: db '  clear         Clear screen', 0
help_reboot: db '  reboot        Reboot system', 0

help_tips: db '[Navigation Tips]', 0
help_tip1: db '  Up/Down arrows   Navigate history', 0
help_tip2: db '  Tab              Auto-complete', 0
help_tip3: db '  .sh files        Execute as script', 0

txt_about:
    db '', 13, 10
    db 'RafOS v2.0 Advanced', 13, 10
    db 'Full-featured 16-bit OS', 13, 10
    db 'File system, text editor', 13, 10
    db 'Shell with history & variables', 13, 10
    db '', 13, 10, 0

msg_unknown: db 'Command not found', 0
msg_listing: db 'Files:', 0
msg_empty: db '(empty)', 0
msg_created: db 'Created: ', 0
msg_deleted: db 'Deleted: ', 0
msg_copied: db 'Copied', 0
msg_moved: db 'Moved', 0
msg_reading: db 'Reading: ', 0
msg_not_found: db 'File not found', 0
msg_disk_full: db 'Disk full', 0
msg_saved: db 'Saved!', 0
msg_exec_script: db 'Executing: ', 0
msg_env: db 'Environment:', 0
msg_no_history: db 'No history', 0

msg_usage_mkdir: db 'Usage: mkdir [name]', 0
msg_usage_touch: db 'Usage: touch [file]', 0
msg_usage_cat: db 'Usage: cat [file]', 0
msg_usage_edit: db 'Usage: edit [file]', 0
msg_usage_rm: db 'Usage: rm [file]', 0
msg_usage_cp: db 'Usage: cp [src] [dst]', 0
msg_usage_mv: db 'Usage: mv [src] [dst]', 0

msg_editor: db '=== Editor: ', 0
msg_editor_help: db 'ESC to save', 0

msg_calc: db '=== Calculator ===', 0
p_n1: db 'Number 1: ', 0
p_op: db 'Operator: ', 0
p_n2: db 'Number 2: ', 0
p_result: db 'Result: ', 0
msg_err: db 'ERROR!', 0

msg_time: db 'Time: ', 0
msg_mem: db 'Memory: ', 0
msg_kb: db ' KB', 0
msg_beep: db 'Beeping...', 0
msg_done: db 'Done!', 0
msg_reboot: db 'Rebooting...', 0

str_root: db '/', 0
str_user_def: db 'user', 0
str_host_def: db 'rafos', 0
str_user_var: db 'USER', 0
str_host_var: db 'HOST', 0
str_path_var: db 'PATH', 0
str_space: db '  ', 0

file1_name: db 'readme.txt', 0
file1_content: db 'Welcome to RafOS v2.0!', 0

color: db 0x0F
buffer_pos: dw 0
history_count: dw 0
history_pos: dw 0
file_count: dw 0

num1: dw 0
num2: dw 0
operator: db 0

current_dir: times 32 db 0
env_user: times 16 db 0
env_host: times 16 db 0
env_path: db '/bin:/usr/bin', 0

buffer: times 64 db 0
cmd_buffer: times 32 db 0
arg1: times 32 db 0
arg2: times 32 db 0
numbuf: times 12 db 0

history: times 1280 db 0
files: times 1280 db 0
edit_buffer: times 512 db 0

times 15360-($-$$) db 0
