.386

; Исходные данные
dseg segment use16
    arr  db 12h, 34h, 56h, 78h, 90h
    code dw 0FFFBh
    symb db 'TBO'
dseg ends

; Результаты
eseg segment use16
    res db ?, ?, ?
eseg ends

cseg segment use16
assume ds:dseg, es:eseg, cs:cseg
m:  mov ax, dseg
    mov ds, ax
    mov ax, eseg
    mov es, ax

    ; Пересылка 3-го однобайтного кода
    mov al, ds:arr+2
    mov es:res, al

    ; Пересылка старшего байта слова
    mov al, byte ptr ds:code+1
    mov es:res+1, al

    ; Пересылка 3-го символа
    mov al, ds:symb+2
    mov es:res+2, al
    
    mov ah, 4ch
    int 21h
cseg ends
end m
