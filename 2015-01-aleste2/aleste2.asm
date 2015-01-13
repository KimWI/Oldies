; Aleste 2 rom version.
; by Ricardo Bittencourt 2015

        output  aleste2.rom

        org     04000h

bdos_call       equ     0F37Dh
dta             equ     0F39Ah ; 2
sliding_dta     equ     0F39Ch ; 2
sectors_left    equ     0F39Eh ; 1
next_sector     equ     0F39Fh ; 2
cartslot        equ     0F3A1h ; 1
rslreg          equ     0138h
exptbl          equ     0FCC1h
enaslt          equ     024h
mainram         equ     0D003h

        db      41h, 42h
        dw      start
        align   16

start:
        ; Where am I
        call    rslreg
        rrca
        rrca
        and     3
        ld      c, a
        ld      b ,0
        ld      hl, exptbl
        add     hl, bc
        or      (hl)
        jp      p, 1f
        ; Slot is extended
        ld      c, a
        inc     hl
        inc     hl
        inc     hl
        inc     hl
        ld      a, (hl)
        and     1100b
        or      c
1:
        ld      (cartslot), a
        ; Init main ram var
        ld      a, 0FFh
        ld      (mainram), a
        ; Copy boot to C000.
        ld      hl, boot
        ld      de, 0C000h
        ld      bc, 256
        ldir
        ; Copy fake bdos to F000.
        ld      hl, fake_bdos
        ld      de, 0F000h
        ld      bc, fake_bdos_end - fake_bdos
        ldir
        ; Replace fake bdos with any existing one.
        ld      a, 0C3h
        ld      (bdos_call), a
        ld      hl, 0F000h
        ld      (bdos_call + 1), hl
        ; Boot the game.
        ld      hl, 0F323h
        ld      de, 0F368h
        jp      0C01Fh

boot:
        incbin  "boot.bin"

index:
        include "index.inc"

        ; Only relocatable code in fake_bdos!
fake_bdos:
        ld      a, c
        cp      01Ah
        jr      z, set_dta
        cp      02Fh
        jr      z, read_sectors
        xor     a
        ret

set_dta:
        ld      (dta), de
        xor     a
        ret

read_sectors:
        di
        ld      a, h
        ld      (sectors_left), a
        ld      hl, (dta)
        ld      (sliding_dta), hl
        ld      (next_sector), de
        ld      a, (cartslot)
        ld      hl, 04000h
        call    enaslt
        ld      a, 1
        ld      (07000h), a
read_sectors_loop:
        ld      hl, (next_sector)
        add     hl, hl
        ld      de, index
        add     hl, de
        ld      e, (hl)
        inc     hl
        ld      d, (hl)
        ex      de, hl
        ; HL now has the virtual sector number.
        ; We need to calculate HL * 512 / 8192.
        add     hl, hl
        ld      d, l
        ld      e, 0
        add     hl, hl
        add     hl, hl
        add     hl, hl
        ; H has the megaram block number.
        ld      a, d
        and     01Fh
        add     a, 60h
        ld      d, a
        ; DE has the megaram offset.
        ld      a, h
        add     a, 2
        ld      (07000h), a
        ld      hl, (sliding_dta)
        ex      de, hl
        ld      bc, 512
        ldir
        ; Repeat for every sector
        ld      hl, (sliding_dta)
        ld      de, 512
        add     hl, de
        ld      (sliding_dta), hl
        ld      hl, (next_sector)
        inc     hl
        ld      (next_sector), hl
        ld      a, (sectors_left)
        dec     a
        ld      (sectors_left), a
        jr      nz, read_sectors_loop
        ; If main ram is detected, switch to main ram
        ld      a, (mainram)
        cp      0FFh
        jr      z, 1f
        ld      hl, 04000h
        call    enaslt
        ; Error code 0 = no error
1:
        xor     a
        ret 

fake_bdos_end:

        align   02000h
        incbin  "data.bin"
        align   02000h
        end

