.model small                           ; assembler directive to allocate memory

.data                                  ; data segment
    arr dw 12, 23, 34, 45, 56, 67, 76, 87, 92, 99      ; array ofsorted 10 numbers
    len dw ($-arr)/2                   ; length of the array
    key equ 56                          ; key to be searched
    msg1 db "key is found at "         ; message 1 to print if key is found
    res db "  position $"              ; message 2 to print if key is found
    msg2 db 'key is not found!!!.$'    ; message to print if key is not found

.code                    ; code segment

     mov ax, @data       ; initialize ds register
     mov ds, ax
     mov bx, 00          ; bx = 0, lower bound 
     mov dx, len         ; dx = len, upper bound
     mov cx, key         ; cx = key to be searched

     searchloop:         ; label Searchloop starts
        cmp bx, dx       ; compare bx with dx
        ja fail          ; if bx > ax i.e. lower bound > upper bound, jump to label fail
        mov ax, bx       ; move bx i.e. lower bound to ax
        add ax, dx       ; add ax with dx, i.e. lower bound with upper bound and store result in ax
        shr ax, 1        ; shift ax right by 1 to divide sum by 2
        mov si, ax       ; move result in ax to si
        add si, si       ; add si with si to point to mid element
        cmp cx, arr[si]  ; compare cx with mid element
        jae high         ; if cx >= mid element, jump to label high else continue
        dec ax           ; decrement ax by one to get mid - 1
        mov dx, ax       ; move dx to ax, change upper bound to mid - 1
        jmp searchloop   ; start the searchloop again

     high:               ; label big
        je match         ; if mid element = cx, jump to match else continue
        inc ax           ; increment ax by one to get mid + 1
        mov bx, ax       ; move ax to bx, change lower bound to mid + 1
        jmp searchloop   ; jump to label searchloop

     match:              ; label Match
        add al, 01       ; add 1 to al to obtain position of key in the array
        add al, 30h      ; add 30 to convert it to integer
        lea si, res      ; load effective address of res in si
        mov [si], al     ; replace character at first location of res with al, i.e. position
        lea dx, msg1     ; load effective address of msg1 in dx
        jmp display      ; jump to label Display

     fail:               ; label fail
        lea dx, msg2     ; load effective address of msg2 in dx

     display:               ; label disp
        mov ah, 09h      ; to print content present in dx
        int 21h
        mov ah, 4ch      ; terminate with return code
        int 21h
        end              ; end directive
