;=============================================================================
; Display Example (c) J.L.Newcombe 2024 (mostly)
;
; Based on examples by Aart Bik
;      https://github.com/maksimKorzh/KIM-1/blob/main/software/Hello/hello.asm
;
; Licence:
;       None
;
; Assembler:
;       cc65,ca65 
;       https://cc65.github.io/doc/ca65.html
;
;
;-----------------------------------------------------------------------------
; Date          Comment
;-----------------------------------------------------------------------------
; 10.08.2024    Created for the Merlin32 compiler by Brutal Delux
; 10:09.2024    Converted to CA65 from Merlin 32
;
;=============================================================================

            .org $0200       ;

            .include "include/kim-symbols.s"
            .include "include/defs.s"
            .include "include/macros.s"

;-----------------------------------------------------------------------------
; Initialise
;-----------------------------------------------------------------------------

            cli
            cld

            lda #$7f            ; set directional registers
            sta PADD
            ;lda #$3f
            ;sta PBDD

            lda #$00            ; store initial value for Y in zero page
            sta $00

            lda #SHIPMID        ; put the space ship in the middle
            sta $01

            lda #$FF
            sta $1707          ; set timer division

;-----------------------------------------------------------------------------
DISPLOOP
;-----------------------------------------------------------------------------
            ; TODO consider adding lead-in and lead-out programmatically
            ;  rather than spaces in the data

            ldy $00             ; initialise character offset from Zero Page
            ldx #$09            ; value representing the left most 7 segment

;-----------------------------------------------------------------------------
CHARLOOP
;-----------------------------------------------------------------------------
            
            lda #$00
            sta SAD             ; do it this way
            stx SBD             ;   to remove flicker
            lda DATA,y
            cmp #$EA            ; check for data terminator
            bne NOTERM
            lda #$00            ; no more data so reset ZP index
            sta $00
            jmp DONE            ; all done

NOTERM      
            ; if we are the first display segment we need to add the space ship
            cpx #$09            ; first segment?
            bne DISP
            ora $01
DISP        sta SAD

;-----------------------------------------------------------------------------
; delay to allow the LEDs to reach full brightness
;-----------------------------------------------------------------------------
            tya                 ; delay added to allow the led to fully light
            ldy #$04            ;   helps a little with the genuine KIM-1
CHARDELAY
            dey
            bne CHARDELAY       ; glow up character
            tay
;-----------------------------------------------------------------------------


;-----------------------------------------------------------------------------
; Detecting key '3' (UP) and key '7' (DOWN) after each segment update
;-----------------------------------------------------------------------------
            txa
            pha
            tya
            pha

KEYS        
            ;jsr KEYIN
            jsr GETKEY
            lda #$7f            ; re-set directional registers
            sta PADD
            ;lda #$3f
            ;sta PBDD

            cmp #$03            ; down
            bne KEYUP
            lda #SHIPBOT        ; bottom segment
            jmp KDONE1

KEYUP       cmp #$07            ; up
            bne KDONE
            lda #SHIPTOP        ; top segment

KDONE1      sta $01             ; store the current space ship char
            
KDONE


            pla
            tay
            pla
            tax
;-----------------------------------------------------------------------------



            iny                 ; increase count
            inx                 ; move to nex 7 segment
            inx
            cpx #$15            ; beyond last segment so 
            bne CHARLOOP        ; next character




;-----------------------------------------------------------------------------
; all segments done, check timer, and start again to refresh display
; if the timer is at zero then update the index to the next char
; FIXME What if we miss the ZERO? This might explain the erratic timing
;-----------------------------------------------------------------------------
            LDA $1707           ; check the timer
            BEQ DONE
            LDA $1706           ; restore divider etc (a read will accomplish this)
            INC $00             ; increment data index low byte



DONE        jmp DISPLOOP        ; refresh the display


DATA

            .include "include/data-level-1.s"
            ;PUT include/data-level-1.s
