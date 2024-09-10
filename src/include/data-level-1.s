METEOR_UP   = %01100011
METEOR_DN   = %01011100

            ; Alphabet
            ; TODO add a specific clear screen function

            ; data in groups of 6
            .byte LSPC,LSPC,LSPC,LSPC,LSPC
DATAROCK    .byte METEOR_DN
            .byte LSPC,LSPC,LSPC,LSPC,LSPC
            .byte DATATERM

