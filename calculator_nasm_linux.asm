section .bss
    first resb 7 ; Первое число длиной 5 символов
    second resb 7 ; Второе число длиной 5 символов
    result resb 8 ; Результат число длиной 6 символов

section .data           ; Секция данных
    hello db "Let's summarize numbers:", 0xA   ; Строка с символом новой строки
    hello_len equ $ - hello        ; Вычисляем длину строки

    prompt1 db "Enter first number: ", 0 ; Сообщение о первом числе
    prompt1_len equ $ - prompt1 ; Вычисляем длину первого запроса

    prompt2 db "Enter second number ", 0 ; Сообщение о втором числе
    prompt2_len equ $ - prompt2 ; Вычисляем длину второго запроса

section .text           ; Секция кода
    global _start       ; Точка входа в программу

_start:                 ; Начало программы
call greetings
call sum
call finish

output:
    ; Готовим к выводу через stdout
    mov eax, 4 ; Номер системного вызова: sys_write
    mov ebx, 1 ; Дескриптор файла: 1 (stdout)
    call enter_first ; вызов запроса ввода данных
    call enter_second ; вызов запроса ввода данных
    ret

greetings:
    ; Пишем строку в stdout
    call output
    mov ecx, hello      ; Адрес строки
    mov edx, hello_len  ; Длина строки
    int 0x80            ; Вызов ядра
    ret

enter_first:
    mov eax, 4 ; запрос sys_write
    mov ebx, 1 ; stdout
    mov ecx, prompt1 ; запись значения в регистр
    mov edx, prompt1_len ; запись длины значения в регистр
    int 0x80 ; вызов ядра
    ret

enter_second:
    mov eax, 4 ; запрос sys_write
    mov sbx, 1 ; stdout
    mov ecx, prompt2 ; запись значения в регистр
    mov edx, prompt2_len ; запись длины значения в регистр
    int 0x80
    ret

sum:
    ; Суммируем
    call output
    mov al, [first] ; Загружаем первое число в регистр al
    add al, [second] ; Прибавляем второе число
    mov ecx, result
    mov edx, result_len
    int 0x80
    ret

finish:
    ; Завершаем программу
    mov eax, 1          ; Номер системного вызова: sys_exit
    xor ebx, ebx        ; Код возврата: 0
    int 0x80            ; Вызов ядра
    ret

asci_to_int:
    xor eax,eax
    ret

converter:
    mov edi, result
    call int_to_asci
    ret