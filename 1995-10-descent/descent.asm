; Descent        
; by Ricardo Bittencourt
; 7/10/95
        
        .386p
        jumps
code32  segment para public use32
        assume cs:code32, ds:code32, ss:code32

include start32.inc
include graph.inc
include kb32.inc
include runloop.inc
include init.inc
include pdosstr.inc
include globals.inc

public  _main

;北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
; DATA
;北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�


;北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
; CODE
;北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�

;哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
;-----------------------------------------------------------------------------
;屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯�
_main:
        call    InitAll
        call    RunLoop
        call    CloseGraph
        call    _reset_kb
        mov     eax,actualframe
        call    _putdecimal
        jmp     _exit

;鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍�
; In:
; Out:
;鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍�

;北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
; In:
; Out:
;北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�

code32  ends
        end

